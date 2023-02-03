import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_3bee/blocs/home/home_bloc.dart';
import 'package:test_3bee/models/apiary.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(const RequestData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home page'),
      ),
      body: SafeArea(
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            final List<Apiary> apiaries = state.apiariesResponse?.results ?? [];
            return Center(
              child: Container(
                color: Colors.orange,
                height: 300,
                child: ListView.builder(
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

class _Foreground extends StatelessWidget {
  final Apiary apiary;

  const _Foreground({
    required this.apiary,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ForegroundTitle(title: apiary.name),
        const _ForegroundWeightInfo(),
        const Spacer(),
        const _ForegroundFooter(),
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
  const _ForegroundWeightInfo({Key? key}) : super(key: key);

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
      child: const Center(
        child: Text(
          '-0.2kg',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
      ),
    );
  }
}

class _ForegroundFooter extends StatelessWidget {
  const _ForegroundFooter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text(
            '21 lug',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          Text(
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
        return const RadialGradient(
          center: Alignment.topLeft,
          radius: 1.0,
          colors: [Colors.grey, Colors.grey],
          tileMode: TileMode.repeated,
        ).createShader(bounds);
      },
      child: Image.network(
        imageUrl ?? '',
        fit: BoxFit.cover,
      ),
    );
  }
}
