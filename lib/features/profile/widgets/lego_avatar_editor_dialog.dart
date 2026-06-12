import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:edufocus/core/themes/app_theme.dart';
import 'package:edufocus/core/utils/lego_character_helper.dart';
import 'package:edufocus/core/utils/widgets/lego_character_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:edufocus/core/network/api_services.dart';
import 'package:edufocus/core/di/di.dart';
import 'package:edufocus/core/bloc/stars_cubit.dart';
import 'package:edufocus/features/subjects/models/avatar_shop_model.dart';

class LegoConfig {
  final int headIndex;
  final int hairIndex;
  final int bodyIndex;
  final int legIndex;
  final int hatIndex;

  LegoConfig({
    required this.headIndex,
    required this.hairIndex,
    required this.bodyIndex,
    required this.legIndex,
    required this.hatIndex,
  });

  LegoConfig copyWith({
    int? headIndex,
    int? hairIndex,
    int? bodyIndex,
    int? legIndex,
    int? hatIndex,
  }) {
    return LegoConfig(
      headIndex: headIndex ?? this.headIndex,
      hairIndex: hairIndex ?? this.hairIndex,
      bodyIndex: bodyIndex ?? this.bodyIndex,
      legIndex: legIndex ?? this.legIndex,
      hatIndex: hatIndex ?? this.hatIndex,
    );
  }
}

class LegoAvatarEditorDialog extends StatefulWidget {
  final LegoConfig initialConfig;

  const LegoAvatarEditorDialog({super.key, required this.initialConfig});

  @override
  State<LegoAvatarEditorDialog> createState() => _LegoAvatarEditorDialogState();
}

class _LegoAvatarEditorDialogState extends State<LegoAvatarEditorDialog> {
  late List<LegoConfig> _history;
  late int _historyIndex;
  int _selectedTab = 0;
  late final Future<void> _prefetchFuture;

  bool _isLoadingShop = true;
  String? _errorMessage;
  AvatarShopModel? _shopModel;
  String? _token;

  @override
  void initState() {
    super.initState();
    _history = [widget.initialConfig];
    _historyIndex = 0;
    _prefetchFuture = LegoCharacterHelper.prefetch();
    _loadShopData();
  }

  Future<void> _loadShopData() async {
    if (!mounted) return;
    setState(() {
      _isLoadingShop = true;
      _errorMessage = null;
    });
    try {
      const secureStorage = FlutterSecureStorage();
      _token = await secureStorage.read(key: 'auth_token');
      if (_token == null) {
        throw "Authentication token not found.";
      }

      final apiServices = getIt<ApiServices>();
      final shop = await apiServices.getAvatarShop(_token!);

      if (!mounted) return;
      setState(() {
        _shopModel = shop;
        _isLoadingShop = false;
      });

      if (context.mounted) {
        context.read<StarsCubit>().setStars(shop.coins ?? 0);
      }

      if (shop.equippedAvatar != null) {
        final serverConfig = LegoConfig(
          headIndex:
              shop.equippedAvatar!.headIndex ?? widget.initialConfig.headIndex,
          hairIndex:
              shop.equippedAvatar!.hairIndex ?? widget.initialConfig.hairIndex,
          bodyIndex:
              shop.equippedAvatar!.bodyIndex ?? widget.initialConfig.bodyIndex,
          legIndex:
              shop.equippedAvatar!.legIndex ?? widget.initialConfig.legIndex,
          hatIndex:
              shop.equippedAvatar!.hatIndex ?? widget.initialConfig.hatIndex,
        );
        if (mounted) {
          setState(() {
            _history = [serverConfig];
            _historyIndex = 0;
          });
        }
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = e.toString();
        _isLoadingShop = false;
      });
    }
  }

  void _showPurchaseDialog(Items item) {
    final price = item.price ?? 50;
    final userCoins = context.read<StarsCubit>().state;
    final hasEnoughCoins = userCoins >= price;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          title: Text(
            hasEnoughCoins ? 'Unlock Piece! 🌟' : 'Need More Coins! 🪙',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: Colors.black87,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8),
              Text(
                hasEnoughCoins
                    ? 'Do you want to buy this item for $price coins?'
                    : 'You need $price coins to buy this, but you only have $userCoins coins. Play more lessons to earn coins!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey.shade700,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            if (hasEnoughCoins) ...[
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber.shade700,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  _buyItem(item);
                },
                child: Text(
                  'Unlock ($price 🪙)',
                  style: const TextStyle(fontWeight: FontWeight.w800),
                ),
              ),
            ] else ...[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.shade400,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'Okay',
                  style: TextStyle(fontWeight: FontWeight.w800),
                ),
              ),
            ],
          ],
        );
      },
    );
  }

  Future<void> _buyItem(Items item) async {
    if (_token == null) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      final apiServices = getIt<ApiServices>();
      await apiServices.buyAvatarItem(item.id ?? '', _token!);

      if (mounted) {
        Navigator.pop(context);
      }

      await _loadShopData();

      final styleNum = item.itemIndex ?? 1;
      _selectStyleForCategory(item.itemType ?? '', styleNum);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Successfully unlocked item! 🎉'),
            backgroundColor: Colors.green.shade600,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        Navigator.pop(context);
      }
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to purchase item: $e'),
            backgroundColor: Colors.red.shade600,
          ),
        );
      }
    }
  }

  void _selectStyleForCategory(String category, int styleNum) {
    LegoConfig newConfig;
    if (category == 'head') {
      newConfig = _currentConfig.copyWith(headIndex: styleNum);
    } else if (category == 'hair') {
      newConfig = _currentConfig.copyWith(hairIndex: styleNum);
    } else if (category == 'body') {
      newConfig = _currentConfig.copyWith(bodyIndex: styleNum);
    } else if (category == 'leg') {
      newConfig = _currentConfig.copyWith(legIndex: styleNum);
    } else if (category == 'hat') {
      newConfig = _currentConfig.copyWith(hatIndex: styleNum);
    } else {
      return;
    }
    _pushState(newConfig);
  }

  LegoConfig get _currentConfig => _history[_historyIndex];

  void _pushState(LegoConfig newConfig) {
    if (_historyIndex < _history.length - 1) {
      _history = _history.sublist(0, _historyIndex + 1);
    }
    _history.add(newConfig);
    _historyIndex = _history.length - 1;
    setState(() {});
  }

  void _undo() {
    if (_historyIndex > 0) {
      setState(() {
        _historyIndex--;
      });
    }
  }

  void _redo() {
    if (_historyIndex < _history.length - 1) {
      setState(() {
        _historyIndex++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: context.colors.background,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: [
              CustomPaint(
                painter: SearchlightPainter(),
                child: Container(
                  height: 280 + topPadding,
                  padding: EdgeInsets.only(top: topPadding),
                  alignment: Alignment.center,
                  child: LegoCharacterWidget(
                    headIndex: _currentConfig.headIndex,
                    hairIndex: _currentConfig.hairIndex,
                    bodyIndex: _currentConfig.bodyIndex,
                    legIndex: _currentConfig.legIndex,
                    hatIndex: _currentConfig.hatIndex,
                    size: 110,
                  ),
                ),
              ),

              Positioned(
                left: 16,
                top: 16 + topPadding,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white70,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: SvgPicture.asset(
                      'assets/images/character/icons/Close.svg',
                      colorFilter: const ColorFilter.mode(
                        Colors.black87,
                        BlendMode.srcIn,
                      ),
                      width: 20,
                      height: 20,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),

              Positioned(
                top: 16 + topPadding,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.85),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.amber.shade600,
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('🪙', style: TextStyle(fontSize: 16)),
                        const SizedBox(width: 6),
                        BlocBuilder<StarsCubit, int>(
                          builder: (context, coins) {
                            return Text(
                              '$coins',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                                color: Colors.amber.shade800,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              Positioned(
                right: 16,
                top: 16 + topPadding,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: context.colors.brandBlue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 4,
                  ),
                  onPressed: () async {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) =>
                          const Center(child: CircularProgressIndicator()),
                    );

                    try {
                      if (_token != null) {
                        await getIt<ApiServices>().equipAvatar(
                          headIndex: _currentConfig.headIndex,
                          hairIndex: _currentConfig.hairIndex,
                          bodyIndex: _currentConfig.bodyIndex,
                          legIndex: _currentConfig.legIndex,
                          hatIndex: _currentConfig.hatIndex,
                          token: _token!,
                        );
                      }
                    } catch (e) {
                      print(
                        "Failed to save avatar configuration on server: $e",
                      );
                    }

                    await LegoCharacterHelper.saveConfig(
                      headIndex: _currentConfig.headIndex,
                      hairIndex: _currentConfig.hairIndex,
                      bodyIndex: _currentConfig.bodyIndex,
                      legIndex: _currentConfig.legIndex,
                      hatIndex: _currentConfig.hatIndex,
                    );

                    if (context.mounted) {
                      Navigator.pop(context);
                      Navigator.pop(context, _currentConfig);
                    }
                  },
                  child: const Text(
                    'Save',
                    style: TextStyle(fontWeight: FontWeight.w800),
                  ),
                ),
              ),

              Positioned(
                left: 16,
                bottom: 16,
                child: Row(
                  children: [
                    _buildHistoryButton(
                      iconPath: 'assets/images/character/icons/Undo.svg',
                      onPressed: _historyIndex > 0 ? _undo : null,
                    ),
                    const SizedBox(width: 12),
                    _buildHistoryButton(
                      iconPath: 'assets/images/character/icons/Redo.svg',
                      onPressed: _historyIndex < _history.length - 1
                          ? _redo
                          : null,
                    ),
                  ],
                ),
              ),
            ],
          ),

          _buildCategoryTabs(),

          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              color: context.colors.cardBackground,
              child: _buildGridContent(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryButton({
    required String iconPath,
    VoidCallback? onPressed,
  }) {
    final enabled = onPressed != null;
    return Container(
      decoration: BoxDecoration(
        color: enabled ? Colors.white70 : Colors.white24,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: SvgPicture.asset(
          iconPath,
          colorFilter: ColorFilter.mode(
            enabled ? Colors.black87 : Colors.black26,
            BlendMode.srcIn,
          ),
          width: 20,
          height: 20,
        ),
        onPressed: onPressed,
      ),
    );
  }

  Widget _buildCategoryTabs() {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: context.colors.background,
        border: Border(
          bottom: BorderSide(color: context.colors.border, width: 1.5),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildTabItem(0, 'assets/images/character/icons/Head.svg', 'Face'),
          _buildTabItem(1, 'assets/images/character/icons/Hair.svg', 'Hair'),
          _buildTabItem(2, 'assets/images/character/icons/Body.svg', 'Shirt'),
          _buildTabItem(3, 'assets/images/character/icons/Leg.svg', 'Pants'),
          _buildTabItem(4, 'assets/images/character/icons/Hat.svg', 'Hat'),
        ],
      ),
    );
  }

  Widget _buildTabItem(int index, String iconPath, String label) {
    final isSelected = _selectedTab == index;
    final color = isSelected
        ? context.colors.brandBlue
        : context.colors.textTertiary;
    return GestureDetector(
      onTap: () => setState(() => _selectedTab = index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            iconPath,
            colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
            width: 24,
            height: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: isSelected ? FontWeight.w800 : FontWeight.w500,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStyleGrid({
    required String title,
    required List<Items> categoryItems,
    required int selectedIndex,
    required Uint8List Function(int) getStyleBytes,
    required ValueChanged<int> onStyleSelected,
    required String category,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w800,
            color: context.colors.textSecondary,
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: FutureBuilder<void>(
            future: _prefetchFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(strokeWidth: 2.5),
                  ),
                );
              }
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: categoryItems.length,
                itemBuilder: (context, index) {
                  final item = categoryItems[index];
                  final styleNum = item.itemIndex ?? 1;
                  final isSelected = selectedIndex == styleNum;
                  final isOwned = item.isOwned ?? false;

                  return GestureDetector(
                    onTap: () {
                      if (!isOwned) {
                        _showPurchaseDialog(item);
                      } else if (!isSelected) {
                        onStyleSelected(styleNum);
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected
                            ? context.colors.brandBlue.withOpacity(0.08)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isSelected
                              ? context.colors.brandBlue
                              : context.colors.border,
                          width: 2.2,
                        ),
                      ),
                      padding: const EdgeInsets.all(6),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned.fill(
                            child: category == 'hat' && styleNum == 0
                                ? SvgPicture.asset(
                                    'assets/images/character/hats/None.svg',
                                    fit: BoxFit.contain,
                                  )
                                : Image.memory(
                                    getStyleBytes(styleNum),
                                    fit: BoxFit.contain,
                                  ),
                          ),
                          if (!isOwned) ...[
                            Positioned(
                              top: 0,
                              right: 0,
                              child: Container(
                                padding: const EdgeInsets.all(3),
                                decoration: const BoxDecoration(
                                  color: Colors.black54,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.lock_rounded,
                                  color: Colors.white,
                                  size: 12,
                                ),
                              ),
                            ),

                            Positioned(
                              bottom: -2,
                              left: 0,
                              right: 0,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.amber.shade700,
                                  borderRadius: const BorderRadius.vertical(
                                    bottom: Radius.circular(12),
                                  ),
                                ),
                                child: Text(
                                  '${item.price ?? 50} 🪙',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 8,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildGridContent() {
    if (_isLoadingShop) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Error loading shop items: $_errorMessage',
              textAlign: TextAlign.center,
              style: TextStyle(color: context.colors.brandRed),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _loadShopData,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    final itemsList = _shopModel?.items ?? [];

    switch (_selectedTab) {
      case 0:
        final categoryItems = itemsList
            .where((item) => item.itemType == 'head')
            .toList();
        categoryItems.sort(
          (a, b) => (a.itemIndex ?? 0).compareTo(b.itemIndex ?? 0),
        );
        return _buildStyleGrid(
          title: 'Choose Face',
          categoryItems: categoryItems,
          selectedIndex: _currentConfig.headIndex,
          getStyleBytes: LegoCharacterHelper.getHeadBytes,
          onStyleSelected: (styleNum) {
            _pushState(_currentConfig.copyWith(headIndex: styleNum));
          },
          category: 'head',
        );

      case 1:
        final categoryItems = itemsList
            .where((item) => item.itemType == 'hair')
            .toList();
        categoryItems.sort(
          (a, b) => (a.itemIndex ?? 0).compareTo(b.itemIndex ?? 0),
        );
        return _buildStyleGrid(
          title: 'Choose Hair',
          categoryItems: categoryItems,
          selectedIndex: _currentConfig.hairIndex,
          getStyleBytes: LegoCharacterHelper.getHairBytes,
          onStyleSelected: (styleNum) {
            _pushState(_currentConfig.copyWith(hairIndex: styleNum));
          },
          category: 'hair',
        );

      case 2:
        final categoryItems = itemsList
            .where((item) => item.itemType == 'body')
            .toList();
        categoryItems.sort(
          (a, b) => (a.itemIndex ?? 0).compareTo(b.itemIndex ?? 0),
        );
        return _buildStyleGrid(
          title: 'Choose Shirt',
          categoryItems: categoryItems,
          selectedIndex: _currentConfig.bodyIndex,
          getStyleBytes: LegoCharacterHelper.getBodyBytes,
          onStyleSelected: (styleNum) {
            _pushState(_currentConfig.copyWith(bodyIndex: styleNum));
          },
          category: 'body',
        );

      case 3:
        final categoryItems = itemsList
            .where((item) => item.itemType == 'leg')
            .toList();
        categoryItems.sort(
          (a, b) => (a.itemIndex ?? 0).compareTo(b.itemIndex ?? 0),
        );
        return _buildStyleGrid(
          title: 'Choose Pants',
          categoryItems: categoryItems,
          selectedIndex: _currentConfig.legIndex,
          getStyleBytes: LegoCharacterHelper.getLegBytes,
          onStyleSelected: (styleNum) {
            _pushState(_currentConfig.copyWith(legIndex: styleNum));
          },
          category: 'leg',
        );

      case 4:
        final categoryItems = itemsList
            .where((item) => item.itemType == 'hat')
            .toList();
        categoryItems.sort(
          (a, b) => (a.itemIndex ?? 0).compareTo(b.itemIndex ?? 0),
        );
        return _buildStyleGrid(
          title: 'Choose Hat',
          categoryItems: categoryItems,
          selectedIndex: _currentConfig.hatIndex,
          getStyleBytes: LegoCharacterHelper.getHatBytes,
          onStyleSelected: (styleNum) {
            _pushState(_currentConfig.copyWith(hatIndex: styleNum));
          },
          category: 'hat',
        );

      default:
        return const SizedBox.shrink();
    }
  }
}

class SearchlightPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final bgPaint = Paint()..color = const Color(0xFFCBE3FF);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bgPaint);

    final beamPaint = Paint()
      ..color = Colors.white.withOpacity(0.18)
      ..style = PaintingStyle.fill;

    final center = Offset(size.width / 2, -30);
    final count = 12;
    final maxRadius = size.height * 1.5;

    for (int i = 0; i < count; i++) {
      if (i % 2 == 0) continue;
      final startAngle = (3.14159 / count) * i;
      final endAngle = (3.14159 / count) * (i + 0.8);

      final path = Path()
        ..moveTo(center.dx, center.dy)
        ..arcTo(
          Rect.fromCircle(center: center, radius: maxRadius),
          startAngle,
          endAngle - startAngle,
          false,
        )
        ..close();

      canvas.drawPath(path, beamPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
