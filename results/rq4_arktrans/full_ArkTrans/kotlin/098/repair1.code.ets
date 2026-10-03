@Entry
@Component
struct Index {
  @State primaryBlack: string = '#1A1A1A'
  @State textGrey: string = '#808080'

  build() {
    Stack({ alignContent: Alignment.Top }) {
      // === LazyColumn (List) ===
      List({ space: 16 }) {
        // === PromoCard ===
        ListItem() {
          Column() {
            Row({ space: 0 }) {
              Column({ space: 4 }) {
                Text('Tip of the day')
                  .fontSize(12)
                  .fontColor(this.textGrey)
                  .fontWeight(FontWeight.Bold)

                Text('Use filtered water for a purer taste profile.')
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(this.primaryBlack)
              }.layoutWeight(1)

              Blank().width(16)

              // Info Icon Circle
              Column() {
                Image($r('app.media.startIcon'))
                  .width(24)
                  .height(24)
                  .objectFit(ImageFit.Contain)
                  .opacity(0.5) // Simulating tint
              }
              .width(48)
              .height(48)
              .borderRadius(24)
              .backgroundColor(Color.White)
              .justifyContent(FlexAlign.Center)
              .alignItems(HorizontalAlign.Center)
            }
            .alignItems(VerticalAlign.Center)
            .padding(24)
            .width('100%')
          }
          .width('100%')
          .backgroundColor('#F0F0F0')
          .borderRadius(20)
        }

        // === Collections Header ===
        ListItem() {
          Text('Collections')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.primaryBlack)
            .margin({ top: 8, bottom: 8 })
        }

        // === TeaItemCard 1 (Sencha Green) ===
        ListItem() {
          this.TeaCardComponent('S', 'Sencha Green', 'Japan', '70°C / 158°F', '1-2 min', '#DFF0D8', '#3C763D')
        }

        // === TeaItemCard 2 (Earl Grey) ===
        ListItem() {
          this.TeaCardComponent('E', 'Earl Grey', 'Blend', '95°C / 203°F', '3-5 min', '#F2DEDE', '#A94442')
        }

        // === TeaItemCard 3 (Silver Needle) ===
        ListItem() {
          this.TeaCardComponent('S', 'Silver Needle', 'China', '80°C / 176°F', '2-3 min', '#E2E3E5', '#31708F')
        }

        // Bottom Spacer
        ListItem() {
          Column().height(80)
        }
      }
      .width('100%')
      .height('100%')
      .padding({ left: 20, right: 20, top: 10, bottom: 10 })

      // === TopAppBar ===
      Column({ space: 0 }) {
        Row({ space: 0 }) {
          Column({ space: 0 }) {
            Text('ZenBrew')
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .fontColor(this.primaryBlack)
              .letterSpacing(-0.5)

            Text('Mindful Steeping Guide')
              .fontSize(14)
              .fontColor(this.textGrey)
              .fontWeight(FontWeight.Normal)
          }
          
          Blank()

          Button() {
            Image($r('app.media.startIcon'))
              .width(24)
              .height(24)
              .fillColor(this.primaryBlack)
          }
          .backgroundColor(Color.Transparent)
        }
        .width('100%')
        .padding({ top: 40, left: 20, right: 20, bottom: 10 })
      }

      // === FAB (Custom Brew) ===
      Button() {
        Row({ space: 8 }) {
          Image($r('app.media.startIcon'))
            .width(24)
            .height(24)
            .fillColor(Color.White)
          
          Text('Custom Brew')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(Color.White)
        }
      }
      .backgroundColor(this.primaryBlack)
      .borderRadius(16)
      .height(56)
      .width('auto')
      .padding({ left: 24, right: 24 })
      .position({ x: 20, y: -100 }) // Relative to bottom alignment logic in stack usually, but here we use absolute positioning relative to parent or just place it at bottom. 
      // Since Stack aligns Top by default, let's position it manually near bottom or use a separate layer.
      // To match screenshot exactly where it overlaps content slightly:
      .position({ x: 20, y: 'calc(100% - 100px)' })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }

  @Builder
  TeaCardComponent(initial: string, name: string, origin: string, temp: string, time: string, bgColor: string, textColor: string) {
    Column() {
      Row({ space: 0 }) {
        // Avatar
        Stack({ alignContent: Alignment.Center }) {
          Text(initial)
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor(textColor)
        }
        .width(50)
        .height(50)
        .borderRadius(25)
        .backgroundColor(bgColor)
        .border({ width: 2, color: textColor, radius: 25 })

        Blank().width(16)

        // Content
        Column({ space: 6 }) {
          Text(name)
            .fontSize(17)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.primaryBlack)

          Text(origin)
            .fontSize(12)
            .fontColor(this.textGrey)

          Row({ space: 8 }) {
            this.Badge(temp)
            this.Badge(time)
          }
        }
        .layoutWeight(1)

        // Play Button
        Button() {
          Image($r('app.media.startIcon'))
            .width(20)
            .height(20)
            .fillColor(this.primaryBlack)
        }
        .width(40)
        .height(40)
        .borderRadius(20)
        .backgroundColor(Color.White)
        .border({ width: 1, color: '#E0E0E0', radius: 20 })
      }
      .alignItems(VerticalAlign.Center)
      .width('100%')
      .padding(16)
    }
    .width('100%')
    .backgroundColor('#FAFAFA')
    .borderRadius(16)
    .border({ width: 1, color: '#EEEEEE', radius: 16 })
  }

  @Builder
  Badge(label: string) {
    Text(label)
      .fontSize(11)
      .fontColor(this.primaryBlack)
      .padding({ left: 6, right: 6, top: 2, bottom: 2 })
      .backgroundColor(Color.White)
      .border({ width: 1, color: '#E0E0E0', radius: 6 })
  }
}