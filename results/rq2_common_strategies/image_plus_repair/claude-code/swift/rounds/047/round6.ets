import hilog from '@ohos.hilog';

@Entry
@Component
struct RootScreen {
  @State message: string = 'Retro Group Buy';

  build() {
    Column() {
      Text(this.message)
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#3E2723')
        .width('100%')
        .textAlign(TextAlign.Start);
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .backgroundColor('#FFF8E1');
  }
}
