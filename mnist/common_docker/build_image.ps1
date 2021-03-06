$DOCKER_NAME = "mnist-tensoorflow"
$REPOSITORY_NAME = "guobowen1990/mnist-pipeline"
$TAG = "0.0.3"
$RUN_TEST = 1

if ($RUN_TEST) {
    cd ..\test
    .\test_pipeline.ps1
    cd ..\common_docker
}

mkdir ./src
cp ../src/* ./src/
docker pull zzn2/tensorflow-with-conda
docker build -t $DOCKER_NAME .

if ($RUN_TEST) {
    docker run -it $DOCKER_NAME ./work_dir/src/run_pipeline.sh
}

Remove-Item -Force -Recurse ./src
docker tag $DOCKER_NAME ${REPOSITORY_NAME}:${TAG}
docker push ${REPOSITORY_NAME}:${TAG}