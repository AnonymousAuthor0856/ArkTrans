@Entry
@Component
struct Index {
  build() {
    Stack() {
      Column() {
        Row() {
          Blank()
          Text('CodeIDE Terminal')
            .fontColor('#E2E8F0')
            .fontSize(34)
            .fontWeight(FontWeight.Bold)
            .textAlign(TextAlign.Center)
            .width('100%')
          Blank()
        }
        .padding({ top: 60, bottom: 20 })

        Scroll() {
          Column() {
            Text('Project Files')
              .fontColor('#E2E8F0')
              .fontSize(20)
              .fontWeight(FontWeight.Medium)
              .margin({ bottom: 16 })

            Column({ space: 12 }) {
              // Item 1
              Row({ space: 16 }) {
                Stack() {
                  Rect().width(32).height(32).borderRadius(6).fill('#0EA5E9')
                  Text('1').fontColor('#FFFFFF').fontSize(14).fontWeight(FontWeight.Bold)
                }
                Column({ space: 4 }) {
                  Text('Main.kt').fontColor('#E2E8F0').fontSize(18).fontWeight(FontWeight.Medium)
                  Text('Entry point for Compose app').fontColor('#CBD5E1').fontSize(14)
                }
              }
              .width('100%')
              .backgroundColor('#334155')
              .borderRadius(12)
              .padding(16)

              // Item 2
              Row({ space: 16 }) {
                Stack() {
                  Rect().width(32).height(32).borderRadius(6).fill('#0EA5E9')
                  Text('2').fontColor('#FFFFFF').fontSize(14).fontWeight(FontWeight.Bold)
                }
                Column({ space: 4 }) {
                  Text('Utils.kt').fontColor('#E2E8F0').fontSize(18).fontWeight(FontWeight.Medium)
                  Text('Helper functions').fontColor('#CBD5E1').fontSize(14)
                }
              }
              .width('100%')
              .backgroundColor('#334155')
              .borderRadius(12)
              .padding(16)

              // Item 3
              Row({ space: 16 }) {
                Stack() {
                  Rect().width(32).height(32).borderRadius(6).fill('#0EA5E9')
                  Text('3').fontColor('#FFFFFF').fontSize(14).fontWeight(FontWeight.Bold)
                }
                Column({ space: 4 }) {
                  Text('Theme.kt').fontColor('#E2E8F0').fontSize(18).fontWeight(FontWeight.Medium)
                  Text('Color & Typography setup').fontColor('#CBD5E1').fontSize(14)
                }
              }
              .width('100%')
              .backgroundColor('#334155')
              .borderRadius(12)
              .padding(16)

              // Item 4
              Row({ space: 16 }) {
                Stack() {
                  Rect().width(32).height(32).borderRadius(6).fill('#0EA5E9')
                  Text('4').fontColor('#FFFFFF').fontSize(14).fontWeight(FontWeight.Bold)
                }
                Column({ space: 4 }) {
                  Text('Data.kt').fontColor('#E2E8F0').fontSize(18).fontWeight(FontWeight.Medium)
                  Text('Repository and model classes').fontColor('#CBD5E1').fontSize(14)
                }
              }
              .width('100%')
              .backgroundColor('#334155')
              .borderRadius(12)
              .padding(16)
            }
            .margin({ bottom: 32 })

            Text('Live Terminal')
              .fontColor('#E2E8F0')
              .fontSize(20)
              .fontWeight(FontWeight.Medium)
              .margin({ bottom: 16 })

            Stack() {
              Rect()
                .width('100%')
                .height(240)
                .borderRadius(12)
                .fill('#334155')
                .border({ width: 1, color: '#475569', radius: 12 })

              Text('> println("Hello, Kotlin!")')
                .fontColor('#E2E8F0')
                .fontSize(14)
                .position({ x: 16, y: 16 })
            }
            .width('100%')
            .margin({ bottom: 32 })

            Button() {
              Text('Run Project')
                .fontColor('#FFFFFF')
                .fontSize(16)
                .fontWeight(FontWeight.Bold)
            }
            .width('100%')
            .height(48)
            .backgroundColor('#0EA5E9')
            .borderRadius(24)
            .shadow({ radius: 8, color: '#00000040', offsetY: 4 })
          }
          .width('100%')
          .padding(16)
        }
        .layoutWeight(1)
        .backgroundColor('#1E293B')
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#1E293B')
    }
    .width('100%')
    .height('100%')
  }
}