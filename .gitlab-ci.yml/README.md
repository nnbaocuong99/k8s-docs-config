```
stages:
  - verify
  - deploy

enforce chart version:
  stage: verify
  tags:
    - runner-150-16
  before_script:
    - chmod +x version-enforce.sh
  script:
    - ./version-enforce.sh $CI_COMMIT_TAG
  only:
    refs:
      - tags

deploy Helm chart:
  stage: deploy
  tags:
    - runner-150-16
  before_script:
    - docker login $HARBOR_URL -u $HARBOR_USERNAME -p $HARBOR_PASSWD
  script:
    - docker run --rm -v "$(pwd)":/chart -w /chart domain/helm-cli:$HELM_CLI_IMAGE_VER push . hub
  only:
    refs:
      - tags
```
