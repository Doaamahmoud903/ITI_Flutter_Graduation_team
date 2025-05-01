import 'package:electro_app_team/providers/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import '../../providers/theme_provider.dart';
import '../../utils/app_assets.dart';
import '../cubits/products/products_cubit.dart';
import 'package:electro_app_team/widgets/search_results_screen.dart';
import 'package:electro_app_team/ui/cart/cart_screen.dart';
import 'package:permission_handler/permission_handler.dart';

class MainAppbar extends StatefulWidget implements PreferredSizeWidget {
  final double height;
  final double width;
  final bool showCartIcon;
  final bool removePadding;

  const MainAppbar({
    super.key,
    required this.width,
    required this.height,
    this.showCartIcon = true,
    this.removePadding = false,
  });

  @override
  Size get preferredSize => const Size.fromHeight(150);

  @override
  _MainAppbarState createState() => _MainAppbarState();
}

class _MainAppbarState extends State<MainAppbar> {
  final TextEditingController _searchController = TextEditingController();
  late stt.SpeechToText _speech;
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  void _onSearchSubmitted(BuildContext context) {
    final query = _searchController.text.trim();
    if (query.isNotEmpty) {
      context.read<ProductsCubit>().fetchProductsWithSearch(query);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const SearchResultsScreen()),
      );
    }
  }

  Future<void> _startListening() async {
    PermissionStatus status = await Permission.microphone.request();
    if (status.isGranted) {
      bool available = await _speech.initialize(
        onStatus: (status) {
          print('Status: $status');
          if (status == "done" || status == "notListening") {
            setState(() {
              _isListening = false;
            });
          }
        },
        onError: (errorNotification) {
          print('Error: $errorNotification');
          setState(() {
            _isListening = false;
          });
        },
      );
      if (available) {
        setState(() {
          _isListening = true;
        });
        _speech.listen(
          onResult: (result) {
            setState(() {
              _searchController.text = result.recognizedWords;
            });
          },
        );
      } else {
        print('Speech recognition not available');
      }
    } else {
      print('Microphone permission denied');
    }
  }

  void _stopListening() {
    _speech.stop();
    setState(() => _isListening = false);
  }

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    var languageProvider = Provider.of<LanguageProvider>(context);
    var height = MediaQuery.of(context).size.height;

    return AppBar(
      toolbarHeight: 150,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // logo
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                themeProvider.currentTheme == ThemeMode.light
                    ? languageProvider.currentLocal == "en"
                        ? AppAssets.mainLogo
                        : AppAssets.logoArDark
                    : languageProvider.currentLocal == "en"
                    ? AppAssets.mainLogoLight
                    : AppAssets.logoArLight,
                height: height * 0.09,
                width: 200,
              ),
            ],
          ),
          // search bar
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: widget.removePadding ? 0 : widget.width * 0.03,
              vertical: widget.height * 0.01,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 300,
                  height: 50,
                  child: TextField(
                    controller: _searchController,
                    onSubmitted: (_) => _onSearchSubmitted(context),
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.searchHint,
                      hintStyle: Theme.of(context).textTheme.headlineSmall,
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(
                              _isListening
                                  ? Icons.fiber_manual_record
                                  : Icons.mic,
                              color:
                                  _isListening
                                      ? Colors.red
                                      : Theme.of(context).primaryColor,
                            ),
                            onPressed:
                                _isListening ? _stopListening : _startListening,
                          ),
                          IconButton(
                            icon: const Icon(Icons.send),
                            onPressed: () => _onSearchSubmitted(context),
                          ),
                        ],
                      ),
                      isCollapsed: true,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 10,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
                widget.showCartIcon
                    ? InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(CartScreen.routeName);
                      },
                      child: ImageIcon(
                        AssetImage(AppAssets.cartIcon),
                        color: Theme.of(context).primaryColor,
                      ),
                    )
                    : const SizedBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
