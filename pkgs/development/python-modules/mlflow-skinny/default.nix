{
  lib,
  buildPythonPackage,
  fetchPypi,
  mlflow,

  # dependencies
  cachetools,
  click,
  cloudpickle,
  databricks-sdk,
  fastapi,
  gitpython,
  importlib-metadata,
  opentelemetry-api,
  opentelemetry-proto,
  opentelemetry-sdk,
  packaging,
  protobuf,
  pydantic,
  python-dotenv,
  pyyaml,
  requests,
  sqlparse,
  starlette,
  typing-extensions,
  uvicorn,
}:

buildPythonPackage (finalAttrs: {
  pname = "mlflow-skinny";
  inherit (mlflow) version;
  format = "wheel";

  # mlflow fetches a PyPI wheel since the JS UI is absent from the GitHub source.
  # mlflow-skinny inherited mlflow's src, but the wheel layout is incompatible with
  # sourceRoot builds, so we also use wheels here too.
  src = fetchPypi {
    pname = "mlflow_skinny";
    inherit (finalAttrs) version;
    format = "wheel";
    dist = "py3";
    python = "py3";
    hash = "sha256-BJjzaXq8q8xiBMQy7xeYQPano0zhI4N8mMGRMGT9pt0=";
  };

  dependencies = [
    cachetools
    click
    cloudpickle
    databricks-sdk
    fastapi
    gitpython
    importlib-metadata
    opentelemetry-api
    opentelemetry-proto
    opentelemetry-sdk
    packaging
    protobuf
    pydantic
    python-dotenv
    pyyaml
    requests
    sqlparse
    starlette
    typing-extensions
    uvicorn
  ];

  pythonImportsCheck = [ "mlflow" ];

  # No tests in the skinny subtree.
  doCheck = false;

  meta = mlflow.meta // {
    description = "Lightweight version of MLflow that is designed to minimize package size";
    homepage = "https://github.com/mlflow/mlflow/tree/master/libs/skinny";
  };
})
