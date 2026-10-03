@Entry
@Component
struct RootScreen {
  @State private knobX: number = 90;
  @State private knobY: number = 140;
  @State private powerOn: boolean = false;

  @Builder
  KnobSurface() {
    Stack() {
      Rect()
        .width(280)
        .height(280)
        .fill('#FFEBC8')
        .radius(24)
      Circle()
        .width(200)
        .height(200)
        .fill('#33FFC300')
      Circle()
        .width(32)
        .height(32)
        .fill('#FF7A00')
        .position({ x: this.knobX, y: this.knobY })
    }
    .width(280)
    .height(280)
    .shadow({ radius: 4, color: '#1F000000', offsetX: 0, offsetY: 2 })
    .padding(16)
  }

  build() {
    Column() {
      Blank().height(40)
      Stack() {
        Rect()
          .width('100%')
          .height(64)
          .fill('#FFF8E7')
        Text('Retro Remote Control')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1E1E1E')
      }
      .height(64)

      Scroll() {
        Column() {
          this.KnobSurface()
          Text(this.powerOn ? 'Power: ON' : 'Power: OFF')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.powerOn ? '#28A745' : '#DC3545')
            .margin({ top: 24 })

          Row() {
            Button('On')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor('#FFFFFF')
              .backgroundColor('#FF7A00')
              .width(80)
              .height(80)
              .borderRadius(40)
              .onClick(() => {
                this.powerOn = !this.powerOn;
              })
            Button() {
              Column() {
                Text('Res')
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#1E1E1E')
                Text('et')
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#1E1E1E')
              }
            }
            .backgroundColor('#FFC300')
            .width(80)
            .height(80)
            .borderRadius(40)
            .margin({ left: 60 })
            .onClick(() => {
              this.knobX = 90;
              this.knobY = 140;
            })
          }
          .justifyContent(FlexAlign.Center)
          .margin({ top: 24 })

          Rect()
            .width('100%')
            .height(6)
            .fill('#FF7A00')
            .radius(3)
            .margin({ left: 16, right: 16, top: 24 })
        }
        .width('100%')
        .padding(16)
      }
      .layoutWeight(1)
      .backgroundColor('#FFF8E7')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFF8E7')
  }
}
