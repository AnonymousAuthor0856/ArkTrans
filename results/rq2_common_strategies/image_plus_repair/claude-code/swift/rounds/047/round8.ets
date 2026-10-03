@Entry
@Component
struct Index {
  @State count: number = 0;

  build() {
    Column() {
      Text('Hello World')
        .fontSize(30)
        .fontWeight(FontWeight.Bold);
      Button('Click')
        .onClick(() => {
          this.count++;
        });
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .backgroundColor('#FFF8E1');
  }
}
