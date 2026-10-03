@Entry
@Component
struct LookAndFeelPage {
  @State appTheme: AppTheme = AppTheme.SYSTEM;
  @State isMaterialYou: boolean = true;
  @State selectedFont: Fonts = Fonts.FIGTREE;

  build() {
    Column() {
      // Top Bar Area (Simulated)
      Row() {
        Button() {
          Text('←')
            .fontSize(20)
            .fontColor('#1D1B20')
        }
        .width(48)
        .height(48)
        .backgroundColor('#E6E0F8')
        .borderRadius(24)
        .margin({ left: 16, top: 16 })

        Text('Look & Feel')
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1D1B20')
          .margin({ left: 16 })
          .alignSelf(ItemAlign.Center)
      }
      .width('100%')
      .height(80)

      Scroll() {
        Column({ space: 24 }) {
          
          // App Theme Section
          Column() {
            Row() {
              Text('⚙')
                .fontSize(20)
                .margin({ right: 12 })
              
              Text('App Theme')
                .fontSize(22)
                .fontWeight(FontWeight.Medium)
                .fontColor('#1D1B20')
            }
            .width('100%')
            .padding({ left: 16, bottom: 12 })

            Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.Start }) {
              ForEach(Object.values(AppTheme).filter(v => typeof v === 'number'), (theme: number) => {
                ToggleChip({
                  label: AppTheme[theme as AppTheme].charAt(0).toUpperCase() + AppTheme[theme as AppTheme].slice(1),
                  isSelected: this.appTheme === theme,
                  onClick: () => {
                    this.appTheme = theme as AppTheme;
                  }
                })
              })
            }
            .width('100%')
            .padding({ left: 56, right: 16, bottom: 8 })
          }

          // Material You Switch
          Row() {
            Column({ space: 4 }) {
              Text('Material You')
                .fontSize(22)
                .fontWeight(FontWeight.Medium)
                .fontColor('#1D1B20')
              
              Text('Use dynamic colors from your wallpaper')
                .fontSize(16)
                .fontColor('#49454F')
            }
            .layoutWeight(1)
            .alignSelf(ItemAlign.Center)

            Toggle({ type: ToggleType.Switch })
              .selected(this.isMaterialYou)
              .onChange((isOn: boolean) => {
                this.isMaterialYou = isOn;
              })
          }
          .width('100%')
          .padding({ left: 16, right: 16, top: 8, bottom: 8 })

          // Font Selection Section
          Column() {
            Row() {
              Text('F')
                .fontSize(20)
                .fontWeight(FontWeight.Medium)
                .margin({ right: 12 })
              
              Text('Font')
                .fontSize(22)
                .fontWeight(FontWeight.Medium)
                .fontColor('#1D1B20')
            }
            .width('100%')
            .padding({ left: 16, bottom: 12 })

            Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.Start, alignItems: ItemAlign.Center }) {
              ForEach(Object.values(Fonts).filter(v => typeof v === 'number'), (font: number) => {
                ToggleChip({
                  label: Fonts[font as Fonts].replace('_', ' '),
                  isSelected: this.selectedFont === font,
                  onClick: () => {
                    this.selectedFont = font as Fonts;
                  }
                })
              })
            }
            .width('100%')
            .padding({ left: 56, right: 16, bottom: 8 })
          }

        }
        .width('100%')
        .padding({ top: 16, bottom: 60 })
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FDF8FD') // Light purple tint background
  }
}

// Reusable Chip Component
@Component
struct ToggleChip {
  @Prop label: string;
  @Prop isSelected: boolean;
  @Prop onClick: () => void;

  build() {
    Button(this.label) {
      Text(this.label)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.isSelected ? '#FFFFFF' : '#49454F')
    }
    .width('auto')
    .height(48)
    .padding({ left: 24, right: 24 })
    .backgroundColor(this.isSelected ? '#6750A4' : '#F2EFF5')
    .borderRadius(16)
    .margin({ right: 8, bottom: 8 })
    .onClick(() => {
      this.onClick();
    })
  }
}

enum AppTheme {
  SYSTEM, DARK, LIGHT
}

enum Fonts {
  POPPINS, INTER, MANROPE, MONTSERRAT, FIGTREE, OUTFIT, GOOGLE_SANS, SYSTEM_DEFAULT
}