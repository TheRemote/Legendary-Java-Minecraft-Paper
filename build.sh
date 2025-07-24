docker build -t 05jchambers/legendary-java-minecraft-paper:amd64 -f amd64.Dockerfile .
docker push 05jchambers/legendary-java-minecraft-paper:amd64

docker build -t 05jchambers/legendary-java-minecraft-paper:arm64v8 -f arm64v8.Dockerfile .
docker push 05jchambers/legendary-java-minecraft-paper:arm64v8

docker build -t 05jchambers/legendary-java-minecraft-paper:armv7 -f armv7.Dockerfile .
docker push 05jchambers/legendary-java-minecraft-paper:armv7

docker build -t 05jchambers/legendary-java-minecraft-paper:ppc64le -f ppc64le.Dockerfile .
docker push 05jchambers/legendary-java-minecraft-paper:ppc64le

docker build -t 05jchambers/legendary-java-minecraft-paper:s390x -f s390x.Dockerfile .
docker push 05jchambers/legendary-java-minecraft-paper:s390x

./manifest-tool-linux-amd64 push from-spec multi-arch-manifest.yaml
