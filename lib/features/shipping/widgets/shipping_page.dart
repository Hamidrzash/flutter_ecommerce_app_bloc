import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:testproject/common/master/master_bloc.dart';
import 'package:testproject/common/pref.dart';
import 'package:testproject/features/shipping/bloc/shipping_bloc.dart';
import 'package:testproject/main.dart';
import 'package:testproject/model/order_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:testproject/common/widgets/app_button.dart';
import 'dart:async';

class ShippingPage extends StatefulWidget {
  const ShippingPage({Key? key}) : super(key: key);

  @override
  State<ShippingPage> createState() => _ShippingPageState();
}

class _ShippingPageState extends State<ShippingPage> {
  late final _bloc = context.read<ShippingBloc>();
  final ScrollController _scrollController = ScrollController();
  late final List<OrderModel> _carts =
      ModalRoute.of(context)!.settings.arguments as List<OrderModel>;

  final Completer<GoogleMapController> _controller = Completer();
  final TextEditingController _editingControllerSearch =
      TextEditingController();
  late final BitmapDescriptor markerBitmap;

  addMarkers() async {
    markerBitmap = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      'assets/images/marker.png',
    );
  }

  initial() async {
    try {
      _bloc.recentAddresses = await Pref().recentAddresses;
      _bloc.recentAddressesLatLng = await Pref().recentAddressesLatLng;
      _bloc.selectedAddress = await Pref().selectedAddress;

      if (_bloc.recentAddresses.isNotEmpty) {
        _bloc.currentLocation = LatLng(
            _bloc.recentAddressesLatLng[_bloc.selectedAddress].latitude,
            _bloc.recentAddressesLatLng[_bloc.selectedAddress].longitude);

        _bloc.add(
          SetLocationEvent(
            latLng: LatLng(
                _bloc.recentAddressesLatLng[_bloc.selectedAddress].latitude,
                _bloc.recentAddressesLatLng[_bloc.selectedAddress].longitude),
          ),
        );

        final GoogleMapController controller = await _controller.future;
        controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
            bearing: 192.8334901395799,
            target: LatLng(
                _bloc.recentAddressesLatLng[_bloc.selectedAddress].latitude,
                _bloc.recentAddressesLatLng[_bloc.selectedAddress].longitude),
            tilt: 59.440717697143555,
            zoom: 19.151926040649414)));
      } else {
        _bloc.add(GetLocationEvent());
      }
    } catch (e) {
      _bloc.add(GetLocationEvent());
    }
  }

  @override
  void initState() {
    addMarkers();
    initial();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Pref().recentAddresses = _bloc.recentAddresses;
        Pref().recentAddressesLatLng = _bloc.recentAddressesLatLng;
        Pref().selectedAddress = _bloc.selectedAddress;
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: GestureDetector(
            onVerticalDragDown: (e) {
              print(e);
              //FocusScope.of(context).unfocus();
            },
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () async {
                          Pref().recentAddresses = _bloc.recentAddresses;
                          Pref().recentAddressesLatLng =
                              _bloc.recentAddressesLatLng;
                          Pref().selectedAddress = _bloc.selectedAddress;
                          Navigator.pop(context);
                        },
                        padding: EdgeInsets.zero,
                        splashRadius: 25,
                        constraints: const BoxConstraints(),
                        icon: SvgPicture.asset(
                          'assets/images/arrow-long-left.svg',
                          height: 18,
                          width: 18,
                        ),
                      ),
                      Text('SHIPPING', style: TextStyles.textStyle3),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () async {},
                            constraints: const BoxConstraints(),
                            splashRadius: 25,
                            padding: EdgeInsets.zero,
                            icon: SvgPicture.asset(
                              'assets/images/dots_menu.svg',
                              height: 20,
                              width: 20,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: CustomScrollView(
                    controller: _scrollController,
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    slivers: [
                      SliverAppBar(
                        collapsedHeight: 0,
                        toolbarHeight: 0,
                        expandedHeight: 480,
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        bottom: PreferredSize(
                          preferredSize: const Size.fromHeight(150),
                          child: Column(
                            children: [
                              Container(
                                height: 150,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.04),
                                      blurRadius: 32,
                                      offset: const Offset(0, -32),
                                    ),
                                  ],
                                  borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(40)),
                                ),
                                child: Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        height: 5,
                                        width: 50,
                                        decoration: BoxDecoration(
                                            color: const Color(0xffF3F6F8),
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 30, vertical: 24),
                                        child: TextField(
                                          cursorColor: Colors.black,
                                          onTap: () {
                                            _scrollController.animateTo(330,
                                                duration: const Duration(
                                                    milliseconds: 1),
                                                curve: Curves.ease);
                                          },
                                          onChanged: (text) {
                                            _scrollController.animateTo(330,
                                                duration: const Duration(
                                                    milliseconds: 1),
                                                curve: Curves.ease);

                                            _bloc.add(SearchLocationEvent(
                                                location: text));
                                          },
                                          onSubmitted: (text) async {},
                                          controller: _editingControllerSearch,
                                          style: TextStyles.textStyle3
                                              .copyWith(color: Colors.black),
                                          decoration: InputDecoration(
                                            fillColor: const Color(0xffF3F6F8),
                                            filled: true,
                                            suffixIconConstraints:
                                                const BoxConstraints(),
                                            hintStyle: TextStyles.textStyle3
                                                .copyWith(color: Colors.black),
                                            hintText: 'Search on CaStore',
                                            suffixIcon: Padding(
                                              padding:
                                                  const EdgeInsets.all(20.0),
                                              child: SvgPicture.asset(
                                                'assets/images/search.svg',
                                                height: 24,
                                                width: 24,
                                              ),
                                            ),
                                            border: const OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(12)),
                                                borderSide: BorderSide.none),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        color: const Color(0xffF3F6F8),
                                        height: 2,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        pinned: true,
                        automaticallyImplyLeading: false,
                        flexibleSpace: Center(
                          child: BlocBuilder<ShippingBloc, MasterState>(
                            builder: (context, state) {
                              return state is RequestLoadingState ||
                                      state is ShippingInitial
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        color: Colors.black54,
                                      ),
                                    )
                                  : GoogleMap(
                                      markers: _bloc.latLng != null
                                          ? {
                                              Marker(
                                                  markerId:
                                                      const MarkerId('id'),
                                                  position: LatLng(
                                                      _bloc.latLng!.latitude,
                                                      _bloc.latLng!.longitude),
                                                  icon: markerBitmap),
                                            }
                                          : {},
                                      mapType: MapType.normal,
                                      mapToolbarEnabled: false,
                                      zoomControlsEnabled: false,
                                      gestureRecognizers: <
                                          Factory<
                                              OneSequenceGestureRecognizer>>{
                                        Factory<OneSequenceGestureRecognizer>(
                                          () => EagerGestureRecognizer(),
                                        ),
                                      },
                                      myLocationEnabled: true,
                                      myLocationButtonEnabled: true,
                                      initialCameraPosition: CameraPosition(
                                        target: LatLng(
                                            _bloc.currentLocation.latitude,
                                            _bloc.currentLocation.longitude),
                                        zoom: 19.5,
                                      ),
                                      onMapCreated:
                                          (GoogleMapController controller) {
                                        _controller.complete(controller);
                                      },
                                    );
                            },
                          ),
                        ),
                      ),
                      SliverFillRemaining(
                        hasScrollBody: false,
                        fillOverscroll: false,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BlocBuilder<ShippingBloc, MasterState>(
                              builder: (context, state) {
                                return state is SearchLocationState
                                    ? Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 30),
                                        child: Column(
                                          children: [
                                            for (int i = 0, b = 0;
                                                i <
                                                        _bloc
                                                            .autoCompleteAddresses
                                                            .length &&
                                                    b < 15;
                                                i++, b++)
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 5),
                                                child: ListTile(
                                                  dense: true,
                                                  contentPadding:
                                                      EdgeInsets.zero,
                                                  visualDensity:
                                                      const VisualDensity(
                                                          horizontal: 0,
                                                          vertical: -4),
                                                  leading: SvgPicture.asset(
                                                    'assets/images/location.svg',
                                                    height: 28,
                                                    width: 28,
                                                  ),
                                                  onTap: () async {
                                                    try {
                                                      FocusScope.of(context)
                                                          .unfocus();
                                                      if (!_bloc.recentAddresses
                                                          .contains(_bloc
                                                              .autoCompleteAddresses[
                                                                  i]
                                                              .address)) {
                                                        _bloc.recentAddresses
                                                            .add(_bloc
                                                                .autoCompleteAddresses[
                                                                    i]
                                                                .address);
                                                        _bloc.selectedAddress =
                                                            _bloc.recentAddresses
                                                                    .length -
                                                                1;

                                                        _bloc
                                                            .recentAddressesLatLng
                                                            .add(_bloc
                                                                .autoCompleteAddresses[i]);
                                                        _editingControllerSearch
                                                            .text = '';
                                                        _bloc.add(SetLocationEvent(
                                                            latLng: LatLng(
                                                                _bloc
                                                                    .autoCompleteAddresses[
                                                                        i]
                                                                    .latitude,
                                                                _bloc
                                                                    .autoCompleteAddresses[
                                                                        i]
                                                                    .longitude)));
                                                        final GoogleMapController
                                                            controller =
                                                            await _controller
                                                                .future;
                                                        controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
                                                            bearing:
                                                                192.8334901395799,
                                                            target: LatLng(
                                                                _bloc
                                                                    .autoCompleteAddresses[
                                                                        i]
                                                                    .latitude,
                                                                _bloc
                                                                    .autoCompleteAddresses[
                                                                        i]
                                                                    .longitude),
                                                            tilt:
                                                                59.440717697143555,
                                                            zoom:
                                                                19.151926040649414)));
                                                        _scrollController.animateTo(
                                                            _scrollController
                                                                .position
                                                                .minScrollExtent,
                                                            duration:
                                                                const Duration(
                                                                    milliseconds:
                                                                        1),
                                                            curve: Curves.ease);
                                                      }
                                                    } catch (e) {
                                                      if (_bloc.recentAddresses
                                                          .contains(
                                                              _editingControllerSearch
                                                                  .text)) {
                                                        _bloc.recentAddresses
                                                            .remove(
                                                                _editingControllerSearch
                                                                    .text);
                                                      }
                                                    }
                                                  },
                                                  horizontalTitleGap: 0,
                                                  minLeadingWidth: 27,
                                                  title: Text(
                                                    _bloc
                                                        .autoCompleteAddresses[
                                                            i]
                                                        .address,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyles.textStyle3
                                                        .copyWith(fontSize: 15),
                                                  ),
                                                  trailing: Container(
                                                      width: 25,
                                                      height: 25,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Colors.transparent,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        border: Border.all(
                                                          width: 2,
                                                          color: const Color(
                                                              0xff02C697),
                                                        ),
                                                      ),
                                                      child: const Center(
                                                        child: Icon(Icons.add,
                                                            color: Color(
                                                                0xff02C697),
                                                            size: 20),
                                                      )),
                                                ),
                                              ),
                                          ],
                                        ),
                                      )
                                    : state is SetLocationState ||
                                            state is SelectAddressState
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 30),
                                                child: Row(
                                                  children: [
                                                    Text('My Addresses',
                                                        style: TextStyles
                                                            .textStyle3),
                                                    const SizedBox(
                                                      width: 15,
                                                    ),
                                                    Image.asset(
                                                      'assets/images/arrow-long-right.png',
                                                      height: 18,
                                                      width: 18,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 30,
                                              ),
                                              for (int index = _bloc
                                                              .recentAddresses
                                                              .length -
                                                          1,
                                                      count = 0;
                                                  index > -1 && count < 5;
                                                  index--, count++)
                                                ListTile(
                                                  leading: SvgPicture.asset(
                                                    'assets/images/location.svg',
                                                    width: 28,
                                                    height: 28,
                                                  ),
                                                  dense: true,
                                                  contentPadding:
                                                      const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 30,
                                                          vertical: 18),
                                                  minVerticalPadding: 5,
                                                  trailing: BlocBuilder<
                                                      ShippingBloc,
                                                      MasterState>(
                                                    builder: (context, state) {
                                                      return Container(
                                                        height: 32,
                                                        width: 32,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors
                                                              .transparent,
                                                          border: Border.all(
                                                              width: 2,
                                                              color: _bloc.selectedAddress ==
                                                                      index
                                                                  ? const Color(
                                                                      0xff02C697)
                                                                  : const Color(
                                                                      0xffF3F6F8)),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(32),
                                                        ),
                                                        child: Center(
                                                          child:
                                                              SvgPicture.asset(
                                                            'assets/images/check.svg',
                                                            color: _bloc.selectedAddress ==
                                                                    index
                                                                ? const Color(
                                                                    0xff02C697)
                                                                : const Color(
                                                                    0xffF3F6F8),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                  onTap: () async {
                                                    _bloc.add(
                                                        SelectAddressEvent(
                                                            address: index));
                                                    _bloc.add(SetLocationEvent(
                                                        latLng: LatLng(
                                                            _bloc
                                                                .recentAddressesLatLng[
                                                                    index]
                                                                .latitude,
                                                            _bloc
                                                                .recentAddressesLatLng[
                                                                    index]
                                                                .longitude)));
                                                    final GoogleMapController
                                                        controller =
                                                        await _controller
                                                            .future;
                                                    controller.animateCamera(CameraUpdate
                                                        .newCameraPosition(CameraPosition(
                                                            bearing:
                                                                192.8334901395799,
                                                            target: LatLng(
                                                                _bloc
                                                                    .recentAddressesLatLng[
                                                                        index]
                                                                    .latitude,
                                                                _bloc
                                                                    .recentAddressesLatLng[
                                                                        index]
                                                                    .longitude),
                                                            tilt:
                                                                59.440717697143555,
                                                            zoom:
                                                                19.151926040649414)));
                                                  },
                                                  title: Text(
                                                    _bloc
                                                        .recentAddresses[index],
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                    style: TextStyles.textStyle3
                                                        .copyWith(
                                                            color:
                                                                Colors.black),
                                                  ),
                                                ),
                                            ],
                                          )
                                        : Container();
                              },
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: BlocBuilder<ShippingBloc, MasterState>(
                                builder: (context, state) {
                                  return AppButton(
                                      text: 'CONTINUE TO PAYMENT',
                                      widget: Image.asset(
                                          'assets/images/arrow-long-right.png'),
                                      function: _bloc.recentAddresses.isNotEmpty
                                          ? () async {
                                              Pref().recentAddresses =
                                                  _bloc.recentAddresses;
                                              Pref().recentAddressesLatLng =
                                                  _bloc.recentAddressesLatLng;
                                              Pref().selectedAddress =
                                                  _bloc.selectedAddress;
                                              Navigator.pushNamed(
                                                  context, "/paymentMethod",
                                                  arguments: [
                                                    _carts,
                                                    _bloc.recentAddresses[
                                                        _bloc.selectedAddress]
                                                  ]);
                                            }
                                          : null);
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
