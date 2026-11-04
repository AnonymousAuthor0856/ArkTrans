@Entry
@Component
struct Index {
  @State powerOn: boolean = false
  @State knobLeft: number = 74
  @State knobTop: number = 124

  private cPrimary: string = '#FF7A00'
  private cSecondary: string = '#FFC300'
  private cTertiary: string = '#FFF3C0'
  private cBackground: string = '#FFF8E7'
  private cSurface: string = '#FFFFFF'
  private cSurfaceVariant: string = '#FFEBC8'
  private cOutline: string = '#BCA789'
  private cSuccess: string = '#28A745'
  private cError: string = '#DC3545'
  private cText: string = '#1E1E1E'

  @Builder
  KnobSurface() {
    Stack({ alignContent: Alignment.Center }) {
      Rect()
        .width(280)
        .height(280)
        .radius(24)
        .fill(this.cSurfaceVariant)
      Circle()
        .width(200)
        .height(200)
        .fill('#33FFC300')
      Circle()
        .width(32)
        .height(32)
        .fill(this.cPrimary)
        .translate({ x: -50, y: 0 })
    }
    .width(280)
    .height(280)
    .borderRadius(24)
    .shadow({ radius: 4, color: '#1F000000', offsetY: 2 })
  }

  build() {
    Column() {
      Blank().height(40)
      Stack({ alignContent: Alignment.Center }) {
        Rect()
          .width('100%')
          .height(64)
          .fill(this.cBackground)
        Text('Retro Remote Control')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.cText)
      }
      .width('100%')
      .height(64)

      Scroll() {
        Column() {
          Column() {
            this.KnobSurface()
          }
          .margin({ top: 16, bottom: 24 })

          Text(this.powerOn ? 'Power: ON' : 'Power: OFF')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.powerOn ? this.cSuccess : this.cError)
            .margin({ bottom: 24 })

          Row() {
            Button('On')
              .width(80)
              .height(80)
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(Color.White)
              .backgroundColor(this.cPrimary)
              .borderRadius(40)
              .onClick(() => {
                this.powerOn = !this.powerOn
              })
            Blank().width(60)
            Button() {
              Column() {
                Text('Res')
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(this.cText)
                Text('et')
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(this.cText)
              }
            }
            .width(80)
            .height(80)
            .backgroundColor(this.cSecondary)
            .borderRadius(40)
            .onClick(() => {
              this.knobLeft = 74
              this.knobTop = 124
            })
          }
          .margin({ bottom: 24 })

          Rect()
            .width('100%')
            .height(6)
            .radius(3)
            .fill(this.cPrimary)
            .margin({ left: 16, right: 16 })
        }
        .width('100%')
        .padding(16)
      }
      .layoutWeight(1)
      .backgroundColor(this.cBackground)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.cBackground)
  }
}
