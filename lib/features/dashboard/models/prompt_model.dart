import 'dart:convert';

PromptModel promptModelFromJson(String str) =>
    PromptModel.fromJson(json.decode(str));

String promptModelToJson(PromptModel data) => json.encode(data.toJson());

class PromptModel {
  PromptModel({
    required this.model,
    required this.prompt,
    required this.temperature,
    required this.maxTokens,
    required this.topP,
    required this.frequencyPenalty,
    required this.presencePenalty,
  });

  String model;
  String prompt;
  double temperature;
  int maxTokens;
  int topP;
  double frequencyPenalty;
  double presencePenalty;

  factory PromptModel.fromJson(Map<String, dynamic> json) => PromptModel(
        model: json["model"],
        prompt: json["prompt"],
        temperature: json["temperature"].toDouble(),
        maxTokens: json["max_tokens"],
        topP: json["top_p"],
        frequencyPenalty: json["frequency_penalty"],
        presencePenalty: json["presence_penalty"],
      );

  Map<String, dynamic> toJson() => {
        "model": model,
        "prompt": prompt,
        "temperature": temperature,
        "max_tokens": maxTokens,
        "top_p": topP,
        "frequency_penalty": frequencyPenalty,
        "presence_penalty": presencePenalty,
      };
}
