import { BusinessError } from '@kit.BasicServicesKit';

// MARK: - Color Extension for Hex
// Helper to create colors from hex strings in ArkTS
function getHexColor(hex: string): string {
  return '#' + hex.replace(/^#/, '');
}

// MARK: - Entry Point
@Entry
@Component
struct LumenAppScreen {
  // State management corresponding to Kotlin's @State
  @State selectedIso: string = '400';
  @State apertureValue: number = 2.8;
  @State selectedSpeedIndex: number = 4;

  private shutterSpeeds: string[] = ['1/1000', '1/500', '1/250', '1/125', '1/60', '1/30', '1/15', '1/8'];

  // Constants for layout
  private screenPadding: number = 24;
  private verticalSpacingLarge: number = 32;
  private verticalSpacingMedium: number = 16;

  build() {
    Column() {
      // Background color covering the whole screen
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor('#FFFFFF')
        .position({ x: 0, y: 0 })
        .zIndex(-1)

      // Main Content Container
      Column() {
        // 1. Header
        HeaderSection()
          .margin({ bottom: this.verticalSpacingMedium })

        // 2. Main Display (The "Shot")
        CurrentSettingsDisplay({
          iso: this.selectedIso,
          aperture: this.apertureValue.toFixed(1),
          shutter: this.shutterSpeeds[this.selectedSpeedIndex]
        })

        Blank().layoutWeight(1)

        // 3. Controls
        Column({ space: this.verticalSpacingLarge }) {
          // ISO Selector
          IsoSelector({
            currentIso: this.selectedIso,
            onIsoSelected: (iso: string) => {
              this.selectedIso = iso;
            }
          })

          // Aperture Slider
          ApertureControl({ value: $apertureValue })

          // Shutter Speed Selector
          ShutterSpeedControl({
            speeds: this.shutterSpeeds,
            selectedIndex: this.selectedSpeedIndex,
            onSelect: (index: number) => {
              this.selectedSpeedIndex = index;
            }
          })
        }

        Blank().layoutWeight(1)

        // 4. Bottom Action
        LogShotButton()
      }
      .padding(this.screenPadding)
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}

// MARK: - Sub-Components

@Component
struct HeaderSection {
  private letterSpacingHeader: number = 2;
  private iconButtonSize: number = 44;

  build() {
    Row() {
      Column({ space: 0 }) {
        Text('LUMEN LOG')
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .letterSpacing(this.letterSpacingHeader)
          .fontColor('#888888')
        
        Text('Roll #034')
          .fontSize(24)
          .fontWeight(FontWeight.Black)
          .fontColor('#000000')
      }

      Blank().layoutWeight(1)

      Row({ space: 0 }) {
        Button() {
          Image($r('app.media.ic_menu')) // Placeholder for SF Symbol line.horizontal.3
            .width(22)
            .height(22)
            .fillColor('#000000')
        }
        .width(this.iconButtonSize)
        .height(this.iconButtonSize)
        .type(ButtonType.Normal)
        .backgroundColor(Color.Transparent)

        Button() {
          Image($r('app.media.ic_settings')) // Placeholder for SF Symbol gear
            .width(22)
            .height(22)
            .fillColor('#000000')
        }
        .width(this.iconButtonSize)
        .height(this.iconButtonSize)
        .type(ButtonType.Normal)
        .backgroundColor(Color.Transparent)
      }
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct CurrentSettingsDisplay {
  iso: string = '';
  aperture: string = '';
  shutter: string = '';

  private cardHeight: number = 160;
  private cornerRadius: number = 16;
  private horizontalPadding: number = 24;
  private dividerHeight: number = 80;
  private detailSpacing: number = 16;

  build() {
    Column() {
      Row() {
        // Aperture (Main Focus)
        Column({ space: 0 }) {
          Text(`f/${this.aperture}`)
            .fontSize(56)
            .fontWeight(FontWeight.Lighter)
            .fontColor('#000000')
            .letterSpacing(-2)
          
          Text('APERTURE')
            .fontSize(12)
            .fontWeight(FontWeight.Bold)
            .fontColor('#888888')
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1.5)
        .margin({ left: this.horizontalPadding })

        // Divider
        Divider()
          .vertical(false)
          .strokeWidth(1)
          .color('#E0E0E0')
          .height(this.dividerHeight)
          .margin({ left: this.horizontalPadding, right: this.horizontalPadding })

        // Details Column
        Column({ space: 0 }) {
          SettingItemSmall({ label: 'ISO', value: this.iso })
          
          Blank().height(this.detailSpacing)
          
          SettingItemSmall({ label: 'SHUTTER', value: this.shutter })
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)
        .margin({ left: this.horizontalPadding })
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height(this.cardHeight)
    .backgroundColor('#F8F8F8')
    .borderRadius(this.cornerRadius)
    .border({ width: 1, color: '#EEEEEE' })
  }
}

@Component
struct SettingItemSmall {
  label: string = '';
  value: string = '';

  build() {
    Column({ space: 0 }) {
      Text(this.value)
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor('#000000')
      
      Text(this.label)
        .fontSize(10)
        .fontWeight(FontWeight.Bold)
        .fontColor('#888888')
    }
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct IsoSelector {
  isoValues: string[] = ['100', '200', '400', '800', '1600', '3200'];
  currentIso: string = '';
  onIsoSelected: (iso: string) => void = () => {};

  private bottomPadding: number = 12;
  private itemWidth: number = 60;
  private itemHeight: number = 36;
  private cornerRadius: number = 50;
  private horizontalSpacing: number = 12;

  build() {
    Column({ space: 0 }) {
      Text('Film Stock ISO')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .margin({ bottom: this.bottomPadding })

      Scroll() {
        Flex({ wrap: FlexWrap.NoWrap, justifyContent: FlexAlign.Start, alignItems: ItemAlign.Center }) {
          ForEach(this.isoValues, (iso: string) => {
            let isSelected = this.currentIso === iso;
            
            Button(iso) {
              // Button content handled by style
            }
            .width(this.itemWidth)
            .height(this.itemHeight)
            .fontSize(13)
            .fontWeight(FontWeight.Medium)
            .fontColor(isSelected ? '#FFFFFF' : '#000000')
            .backgroundColor(isSelected ? '#000000' : Color.Transparent)
            .borderRadius(this.cornerRadius)
            .border({ 
              width: 1, 
              color: isSelected ? '#000000' : '#E0E0E0',
              radius: this.cornerRadius 
            })
            .onClick(() => {
              this.onIsoSelected(iso);
            })
            .margin({ right: this.horizontalSpacing })
          }, (iso: string) => iso)
        }
        .width('100%')
      }
      .scrollable(ScrollDirection.Horizontal)
      .scrollBar(BarState.Off)
      .width('100%')
    }
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct ApertureControl {
  @Link value: number;

  private sliderTopSpacing: number = 8;
  private iconSize: number = 16;
  private trackHeight: number = 2;
  private thumbDiameter: number = 28;
  
  // Range constants
  private minVal: number = 1.4;
  private maxVal: number = 16.0;
  private step: number = 0.73; // Approximate step for 20 steps

  build() {
    Column({ space: 0 }) {
      Row() {
        Text('Aperture Control')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
        
        Blank().layoutWeight(1)
        
        Image($r('app.media.ic_settings'))
          .width(this.iconSize)
          .height(this.iconSize)
          .fillColor('#888888')
      }
      .width('100%')

      Blank().height(this.sliderTopSpacing)

      // Custom Slider Implementation
      Stack({ alignContent: Alignment.Start }) {
        // Inactive Track
        Rect()
          .width('100%')
          .height(this.trackHeight)
          .fill('#E0E0E0')
          .borderRadius(this.trackHeight / 2)

        // Active Track
        Rect()
          .width(`${((this.value - this.minVal) / (this.maxVal - this.minVal)) * 100}%`)
          .height(this.trackHeight)
          .fill('#000000')
          .borderRadius(this.trackHeight / 2)

        // Thumb
        Circle()
          .width(this.thumbDiameter)
          .height(this.thumbDiameter)
          .fill('#000000')
          .position({ 
            x: `${((this.value - this.minVal) / (this.maxVal - this.minVal)) * 100}%`, 
            y: '50%' 
          })
          .translate({ x: -this.thumbDiameter / 2, y: -this.thumbDiameter / 2 })
          .shadow({ radius: 2, color: '#00000033' })

        // Interactive Slider (Invisible but functional)
        Slider({ 
          value: this.value, 
          min: this.minVal, 
          max: this.maxVal, 
          step: this.step 
        })
          .width('100%')
          .trackThickness(this.thumbDiameter) // Make touch area larger
          .selectedColor(Color.Transparent)
          .trackColor(Color.Transparent)
          .blockColor(Color.Transparent)
          .onChange((value: number) => {
            this.value = value;
          })
      }
      .height(this.thumbDiameter)
      .width('100%')

      Row() {
        Text('f/1.4')
          .fontSize(12)
          .fontColor('#888888')
        
        Blank().layoutWeight(1)
        
        Text('f/16')
          .fontSize(12)
          .fontColor('#888888')
      }
      .width('100%')
    }
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct ShutterSpeedControl {
  speeds: string[] = [];
  selectedIndex: number = 0;
  onSelect: (index: number) => void = () => {};

  private bottomPadding: number = 12;
  private horizontalSpacing: number = 12;

  build() {
    Column({ space: 0 }) {
      Text('Shutter Speed')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .margin({ bottom: this.bottomPadding })

      Row({ space: this.horizontalSpacing }) {
        // Previous Option
        let prevIndex = this.selectedIndex - 1;
        let prevText = prevIndex >= 0 ? this.speeds[prevIndex] : '-';
        
        SpeedOption({
          text: prevText,
          isSelected: false,
          onClick: () => {
            if (this.selectedIndex > 0) {
              this.onSelect(this.selectedIndex - 1);
            }
          }
        })

        // Current Option
        SpeedOption({
          text: this.speeds[this.selectedIndex],
          isSelected: true,
          onClick: () => {}
        })

        // Next Option
        let nextIndex = this.selectedIndex + 1;
        let nextText = nextIndex < this.speeds.length ? this.speeds[nextIndex] : '-';
        
        SpeedOption({
          text: nextText,
          isSelected: false,
          onClick: () => {
            if (this.selectedIndex < this.speeds.length - 1) {
              this.onSelect(this.selectedIndex + 1);
            }
          }
        })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct SpeedOption {
  text: string = '';
  isSelected: boolean = false;
  onClick: () => void = () => {};

  private itemWidth: number = 100;
  private itemHeight: number = 50;
  private cornerRadius: number = 12;

  build() {
    Column() {
      Button() {
        Text(this.text)
          .fontSize(this.isSelected ? 22 : 16)
          .fontWeight(this.isSelected ? FontWeight.Bold : FontWeight.Normal)
          .fontColor(this.isSelected ? '#000000' : '#E0E0E0')
          .textAlign(TextAlign.Center)
      }
      .width(this.itemWidth)
      .height(this.itemHeight)
      .backgroundColor(this.isSelected ? '#F0F0F0' : Color.Transparent)
      .borderRadius(this.cornerRadius)
      .onClick(() => {
        if (!this.isSelected && this.text !== '-') {
          this.onClick();
        }
      })
    }
  }
}

@Component
struct LogShotButton {
  private buttonHeight: number = 56;
  private cornerRadius: number = 12;
  private iconBoxSize: number = 24;
  private iconSize: number = 16;
  private iconTextSpacing: number = 12;
  private letterSpacingButton: number = 1;

  build() {
    Button() {
      Row({ space: this.iconTextSpacing }) {
        // Icon Box
        Stack() {
          Circle()
            .width(this.iconBoxSize)
            .height(this.iconBoxSize)
            .fill('#FFFFFF')
          
          Image($r('app.media.ic_add')) // Placeholder for SF Symbol plus
            .width(this.iconSize)
            .height(this.iconSize)
            .fillColor('#000000')
        }
        .width(this.iconBoxSize)
        .height(this.iconBoxSize)

        Text('LOG EXPOSURE')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .letterSpacing(this.letterSpacingButton)
          .fontColor('#FFFFFF')
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height(this.buttonHeight)
    .backgroundColor('#000000')
    .borderRadius(this.cornerRadius)
  }
}