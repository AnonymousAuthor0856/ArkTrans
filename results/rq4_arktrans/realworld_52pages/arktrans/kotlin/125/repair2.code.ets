@Entry
@Component
struct Index {
  @State selectedTheme: string = 'System'
  @State isMaterialYouOn: boolean = true
  @State selectedFont: string = 'Figtree'

  build() {
    Stack({ alignContent: Alignment.Top }) {
      // === LazyColumn ===
      List({ space: 16 }) {
        // === GroupedListItem (App Theme) ===
        ListItem() {
          Column({ space: 24 }) {
            Row({ space: 12 }) {
              Text('⚙').fontSize(20).fontColor('#1C1B1F')
              Text('App Theme').fontSize(22).fontWeight(FontWeight.Medium).fontColor('#1C1B1F')
            }

            // Theme Chips
            Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.Start }) {
              this.renderThemeChip('System')
              this.renderThemeChip('Dark')
              this.renderThemeChip('Light')
            }.margin({ left: 12 })
          }.width('100%').padding({ left: 12, right: 12, top: 8, bottom: 8 })
        }

        // === SwitchSettingItem (Material You) ===
        ListItem() {
          Row({ space: 12 }) {
            Column({ space: 4 }) {
              Text('Material You').fontSize(22).fontWeight(FontWeight.Medium).fontColor('#1C1B1F')
              Text('Use dynamic colors from your wallpaper').fontSize(14).fontColor('#49454F')
            }.layoutWeight(1)
            
            Toggle({ type: ToggleType.Switch })
              .width(52).height(32)
              .selected(this.isMaterialYouOn)
              .onChange((isOn: boolean) => {
                this.isMaterialYouOn = isOn
              })
          }.width('100%').padding({ left: 12, right: 12, top: 8, bottom: 8 })
        }

        // === Font Section ===
        ListItem() {
          Column({ space: 24 }) {
            Row({ space: 12 }) {
              Text('F').fontSize(20).fontColor('#1C1B1F')
              Text('Font').fontSize(22).fontWeight(FontWeight.Medium).fontColor('#1C1B1F')
            }

            // Font Grid
            Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.Start }) {
              this.renderFontChip('Poppins')
              this.renderFontChip('Inter')
              this.renderFontChip('Manrope')
              this.renderFontChip('Montserrat')
              this.renderFontChip('Figtree')
              this.renderFontChip('Outfit')
              this.renderFontChip('Google_sans')
              this.renderFontChip('System_default')
            }.margin({ left: 12 })
          }.width('100%').padding({ left: 12, right: 12, top: 8, bottom: 8 })
        }
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#FDF8FD')
      .edgeEffect(EdgeEffect.Spring)

      // === LargeTopAppBar ===
      Column() {
        Row() {
          Button() {
            Text('←').fontColor('#1C1B1F').fontSize(20)
          }
          .type(ButtonType.Circle)
          .backgroundColor('#EADDFF')
          .width(48).height(48)
          .margin({ left: 12, top: 12 })
          
          Blank()
        }.width('100%')
        
        Text('Look & Feel')
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1C1B1F')
          .margin({ left: 12, top: 8, bottom: 16 })
      }
      .width('100%')
      .backgroundColor('#FDF8FD')
    }.width('100%').height('100%')
  }

  @Builder
  renderThemeChip(name: string) {
    Button(name) {
      Text(name).fontColor(this.selectedTheme === name ? '#FFFFFF' : '#49454F').fontSize(16).fontWeight(FontWeight.Medium)
    }
    .type(ButtonType.Capsule)
    .backgroundColor(this.selectedTheme === name ? '#6750A4' : '#F3EFF4')
    .width(110).height(48)
    .margin({ right: 8, bottom: 8 })
    .onClick(() => {
      this.selectedTheme = name
    })
  }

  @Builder
  renderFontChip(name: string) {
    Button(name) {
      Text(name).fontColor(this.selectedFont === name ? '#FFFFFF' : '#49454F').fontSize(16).fontWeight(FontWeight.Medium)
    }
    .type(ButtonType.Capsule)
    .backgroundColor(this.selectedFont === name ? '#6750A4' : '#F3EFF4')
    .width(130).height(48)
    .margin({ right: 8, bottom: 8 })
    .onClick(() => {
      this.selectedFont = name
    })
  }
}