import 'package:flutter/material.dart';
import 'package:maid/classes/large_language_model.dart';
import 'package:maid/ui/desktop/widgets/parameters/api_key_parameter.dart';
import 'package:maid/ui/desktop/widgets/parameters/seed_parameter.dart';
import 'package:maid/ui/desktop/widgets/parameters/temperature_parameter.dart';
import 'package:maid/ui/desktop/widgets/parameters/top_p_parameter.dart';
import 'package:maid/ui/desktop/widgets/parameters/url_parameter.dart';
import 'package:maid/ui/shared/widgets/session_busy_overlay.dart';

class MistralAiPanel extends StatelessWidget {
  const MistralAiPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "MistralAI Parameters",
          maxLines: 2,
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: SessionBusyOverlay(
        child: ListView(
          padding: const EdgeInsets.all(8.0),
          children: [
            Align(
              alignment: Alignment.center,
              child: FilledButton(
                onPressed: () {
                  LargeLanguageModel.of(context).reset();
                },
                child: Text(
                  "Reset",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
            ),
            buildDivider(context),
            buildWrap(),
            buildDivider(context),
            buildGridView(context),
          ]
        ),
      )
    );
  }

  Widget buildDivider(BuildContext context) {
    return Divider(
      height: 20,
      indent: 10,
      endIndent: 10,
      color: Theme.of(context).colorScheme.primary,
    );
  }

  Widget buildWrap() {
    return const Wrap(
      alignment: WrapAlignment.center,
      spacing: 8,
      runSpacing: 4,
      children: [
        UrlParameter(),
        ApiKeyParameter()
      ],
    );
  }

  Widget buildGridView(BuildContext context) {
    return GridView(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 250,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        childAspectRatio: 1.25
      ),
      shrinkWrap: true,
      children: const [
        SeedParameter(),
        TopPParameter(),
        TemperatureParameter(),
      ],
    );
  }
}

 
