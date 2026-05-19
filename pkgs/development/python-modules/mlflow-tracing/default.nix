{
  lib,
  buildPythonPackage,
  fetchPypi,
  mlflow,

  # dependencies
  cachetools,
  databricks-sdk,
  opentelemetry-api,
  opentelemetry-proto,
  opentelemetry-sdk,
  packaging,
  protobuf,
  pydantic,
}:
buildPythonPackage (finalAttrs: {
  pname = "mlflow-tracing";
  inherit (mlflow) version;
  format = "wheel";

  # mlflow fetches a PyPI wheel since the JS UI is absent from the GitHub source.
  # mlflow-tracing inherited mlflow's src, but the wheel layout is incompatible with
  # sourceRoot builds, so we also use wheels here too.
  src = fetchPypi {
    pname = "mlflow_tracing";
    inherit (finalAttrs) version;
    format = "wheel";
    dist = "py3";
    python = "py3";
    hash = "sha256-xgclU/R7QlBdx+5ilGaIpKDd6PBrePvGDpRjl7IOFRg=";
  };

  dependencies = [
    cachetools
    databricks-sdk
    opentelemetry-api
    opentelemetry-proto
    opentelemetry-sdk
    packaging
    protobuf
    pydantic
  ];

  pythonImportsCheck = [ "mlflow.tracing" ];

  # No tests
  doCheck = false;

  meta = {
    description = "Open-Source SDK for observability and monitoring GenAI applications";
    homepage = "https://github.com/mlflow/mlflow/tree/master/libs/tracing";
    inherit (mlflow.meta) license;
    maintainers = with lib.maintainers; [ GaetanLepage ];
  };
})
