import Foundation
import CreateML

let dir = URL(fileURLWithPath: CommandLine.arguments.count > 1 ? CommandLine.arguments[1] : FileManager.default.currentDirectoryPath)

func table(_ name: String) throws -> MLDataTable {
    try MLDataTable(contentsOf: dir.appendingPathComponent(name))
}

let training = try table("Trail10k.csv")
let testing = try table("Trail1k.csv")
let examples = try table("TrailExamples.csv")
let features = ["distance", "elevation", "terrain", "dangerous"]
let target = "risk"

func metricsLine(_ name: String, _ metrics: MLRegressorMetrics) -> String {
    "\(name) maxError=\(metrics.maximumError) rmse=\(metrics.rootMeanSquaredError)"
}

func writeModel(_ regressor: MLRegressor, name: String) throws {
    let url = dir.appendingPathComponent("\(name).mlmodel")
    try regressor.write(to: url, metadata: nil)
    print("wrote \(url.path)")
}

print("training rows=\(training.rows.count) testing rows=\(testing.rows.count) examples rows=\(examples.rows.count)")

let automatic = try MLRegressor(trainingData: training, targetColumn: target, featureColumns: features)
print(metricsLine("automatic train", automatic.trainingMetrics))
print(metricsLine("automatic valid", automatic.validationMetrics))
print(metricsLine("automatic test", automatic.evaluation(on: testing)))
print(metricsLine("automatic examples", automatic.evaluation(on: examples)))
try writeModel(automatic, name: "TrailAnalyzer")
try writeModel(automatic, name: "TrailAnalyzer Automatic")

let tree = try MLDecisionTreeRegressor(trainingData: training, targetColumn: target, featureColumns: features)
let treeReg = MLRegressor.decisionTree(tree)
print(metricsLine("decisionTree train", treeReg.trainingMetrics))
print(metricsLine("decisionTree valid", treeReg.validationMetrics))
print(metricsLine("decisionTree test", treeReg.evaluation(on: testing)))
print(metricsLine("decisionTree examples", treeReg.evaluation(on: examples)))
try writeModel(treeReg, name: "TrailAnalyzer Decision Tree")

let linear = try MLLinearRegressor(trainingData: training, targetColumn: target, featureColumns: features)
let linearReg = MLRegressor.linear(linear)
print(metricsLine("linear train", linearReg.trainingMetrics))
print(metricsLine("linear valid", linearReg.validationMetrics))
print(metricsLine("linear test", linearReg.evaluation(on: testing)))
print(metricsLine("linear examples", linearReg.evaluation(on: examples)))
try writeModel(linearReg, name: "TrailAnalyzer Linear Regression")
