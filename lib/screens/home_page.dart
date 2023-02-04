import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:test_3bee/blocs/home/home_bloc.dart';
import 'package:test_3bee/core/enums/request_status.dart';
import 'package:test_3bee/models/apiary.dart';
import 'package:test_3bee/widgets/custom_snackbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ScrollController _scrollController;
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(const RequestData());
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.offset == _scrollController.position.maxScrollExtent) {
        context.read<HomeBloc>().add(const RequestData(showLoader: false));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home page'),
      ),
      body: SafeArea(
        child: BlocConsumer<HomeBloc, HomeState>(
          listenWhen: (prev, curr) => prev.requestStatus != curr.requestStatus,
          listener: (context, state) {
            if (state.requestStatus == RequestStatus.failure) {
              context.showErrorSnackBar(message: 'Errore nel recupero dei dati');
            }
          },
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            final List<Apiary> apiaries = state.apiariesResponse?.results ?? [];

            if (apiaries.isEmpty) {
              return const Center(
                child: Text('Nessun risultato trovato'),
              );
            }

            return Center(
              child: Container(
                color: Colors.orange,
                height: 300,
                child: ListView.builder(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: apiaries.length,
                  itemBuilder: (context, index) {
                    final Apiary apiary = apiaries[index];
                    return _ApiaryItem(apiary: apiary);
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _ApiaryItem extends StatelessWidget {
  final Apiary apiary;

  const _ApiaryItem({
    required this.apiary,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            border: Border.all(
              color: const Color(0xFFA7C263),
              width: 2,
            ),
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            child: Stack(
              fit: StackFit.expand,
              children: [
                _Background(imageUrl: apiary.imageUrl),
                _Foreground(apiary: apiary),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Foreground extends StatefulWidget {
  final Apiary apiary;

  const _Foreground({
    required this.apiary,
    Key? key,
  }) : super(key: key);

  @override
  State<_Foreground> createState() => _ForegroundState();
}

class _ForegroundState extends State<_Foreground> {
  late int timestamp;
  late String weight;

  @override
  void initState() {
    super.initState();
    timestamp = widget.apiary.getLatestTimestamp();
    weight = widget.apiary.getWeightOfTimestamp(timestamp);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ForegroundTitle(title: widget.apiary.name),
        _ForegroundWeightInfo(weight: weight),
        const Spacer(),
        _ForegroundFooter(timestamp: timestamp),
      ],
    );
  }
}

class _ForegroundTitle extends StatelessWidget {
  final String title;

  const _ForegroundTitle({
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
      child: Wrap(
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ],
      ),
    );
  }
}

class _ForegroundWeightInfo extends StatelessWidget {
  final String weight;

  const _ForegroundWeightInfo({
    required this.weight,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 110,
      decoration: const BoxDecoration(
        color: Color(0xFFA7C263),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(45),
          bottomRight: Radius.circular(45),
        ),
      ),
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              weight,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            const Text(
              'kg',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFeatures: [FontFeature.subscripts()],
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ForegroundFooter extends StatefulWidget {
  final int timestamp;

  const _ForegroundFooter({
    required this.timestamp,
    Key? key,
  }) : super(key: key);

  @override
  State<_ForegroundFooter> createState() => _ForegroundFooterState();
}

class _ForegroundFooterState extends State<_ForegroundFooter> {
  late DateTime dateTime;
  late String formattedDateTime;

  @override
  void initState() {
    super.initState();
    dateTime = DateTime.fromMillisecondsSinceEpoch(widget.timestamp * 1000);
    final DateFormat formatter = DateFormat('dd LLL');
    formattedDateTime = formatter.format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            formattedDateTime,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          const Text(
            '757706',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}

class _Background extends StatelessWidget {
  final String? imageUrl;

  const _Background({
    required this.imageUrl,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return RadialGradient(
          center: Alignment.topLeft,
          radius: 1.0,
          colors: [Colors.grey.shade600, Colors.grey.shade600],
          tileMode: TileMode.repeated,
        ).createShader(bounds);
      },
      child: Image.network(
        imageUrl ?? 'https://i.pinimg.com/736x/2d/d4/4b/2dd44b3684ea4750ace4660ebc956051.jpg',
        fit: BoxFit.cover,
      ),
    );
  }
}
