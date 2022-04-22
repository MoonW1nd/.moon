echo $REMOTE_DEV_SERVER

rsync -rlptzv \
    --delete \
    --progress \
    --exclude=.svn \
    --exclude=.enb \
    --exclude=.git \
    --exclude=.idea \
    --exclude=.veendor \
    --exclude=.vscode \
    --exclude=build \
    --exclude=client.next \
    --exclude=coverage \
    --exclude=desktop.bundles \
    --exclude=flow-typed \
    --exclude=freeze \
    --exclude=html_reports \
    --exclude=app \
    --exclude=marketnode \
    --exclude=/reports \
    --exclude=/node_modules \
    --exclude=version /Users/moonw1nd/Documents/develop/work/arcadia/market/front/apps/affiliate/ $REMOTE_DEV_SERVER://home/moonw1nd/affiliate_moonw1nd/

# rsync -r --delete --ignore-existing --exclude=.enb --exclude=.git --exclude=.idea --exclude=.veendor --exclude=.vscode --exclude=build --exclude=client.next --exclude=coverage --exclude=desktop.bundles --exclude=flow-typed --exclude=freeze --exclude=html_reports --exclude=app --exclude=marketnode --exclude=/reports --exclude=/node_modules --exclude=version /Users/moonw1nd/Documents/Develop/work/affiliate/ moonw1nd@market.logrus01vd.yandex.ru://home/moonw1nd/node.affiliate_moonw1nd/
# rsync -rlptzv --progress --exclude=.enb --exclude=.git --exclude=.idea --exclude=.veendor --exclude=.vscode --exclude=build --exclude=client.next --exclude=coverage --exclude=desktop.bundles --exclude=flow-typed --exclude=freeze --exclude=html_reports --exclude=app --exclude=marketnode --exclude=/reports --exclude=/node_modules --exclude=version /Users/moonw1nd/Documents/Develop/work/affiliate/ moonw1nd@market.logrus01ed.yandex.ru://home/moonw1nd/node.affiliate_moonw1nd/

