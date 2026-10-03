// LumenApp.ets

// MARK: - Entry Point
@Entry
@Component
struct LumenAppScreen {
  @State selectedIso: string = "400";
  @State apertureValue: number = 2.8;
  @State selectedSpeedIndex: number = 4;

  private shutterSpeeds: string[] = ["1/1000", "1/500", "1/250", "1/125", "1/60", "1/30", "1/15", "1/8"];
  
  private screenPadding: number = 24;
  private verticalSpacingLarge: number = 32;
  private verticalSpacingMedium: number = 16;

  build() {
    Column() {
      // 1. Header
      HeaderSection()

      // 2. Main Display (The "Shot")
      CurrentSettingsDisplay({
        iso: this.selectedIso,
        aperture: this.apertureValue.toFixed(1),
        shutter: this.shutterSpeeds[this.selectedSpeedIndex]
      })

      // Spacer to push content
      Blank()

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
        ApertureControl({
          value: this.apertureValue,
          onChange: (val: number) => {
            this.apertureValue = val;
          }
        })
        
        // Shutter Speed Selector
        ShutterSpeedControl({
          speeds: this.shutterSpeeds,
          selectedIndex: this.selectedSpeedIndex,
          onSelect: (index: number) => {
            this.selectedSpeedIndex = index;
          }
        })
      }
      .width('100%')

      // Spacer to push content
      Blank()

      // 4. Bottom Action
      LogShotButton()
    }
    .width('100%')
    .height('100%')
    .padding(this.screenPadding)
    .backgroundColor('#FFFFFF')
  }
}

// MARK: - Sub-Components

// Header Section
@Component
struct HeaderSection {
  private iconButtonSize: number = 44;

  build() {
    Row() {
      Column() {
        Text("LUMEN LOG")
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor('#808080')
          .letterSpacing(2)
        
        Text("Roll #034")
          .fontSize(24)
          .fontWeight(FontWeight.Bolder) // Fixed: FontWeight.Black -> FontWeight.Bolder
          .fontColor('#000000')
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Row() {
        Button() {
          Text("≡")
            .fontSize(22)
            .fontColor('#000000')
        }
        .width(this.iconButtonSize)
        .height(this.iconButtonSize)
        .backgroundColor(Color.Transparent)
        .onClick(() => {})
        
        Button() {
          Text("⚙")
            .fontSize(22)
            .fontColor('#000000')
        }
        .width(this.iconButtonSize)
        .height(this.iconButtonSize)
        .backgroundColor(Color.Transparent)
        .onClick(() => {})
      }
    }
    .width('100%')
    .padding({ bottom: 16 })
  }
}

// Current Settings Display
@Component
struct CurrentSettingsDisplay {
  private iso: string = "400";
  private aperture: string = "2.8";
  private shutter: string = "1/60";

  private cardHeight: number = 160;
  private cornerRadius: number = 16;
  private horizontalPadding: number = 24;
  private dividerHeight: number = 80;

  build() {
    Row() {
      // Aperture (Main Focus)
      Column() {
        Text(`f/${this.aperture}`)
          .fontSize(56)
          .fontWeight(FontWeight.Lighter)
          .fontColor('#000000')
          .letterSpacing(-2)
        
        Text("APERTURE")
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor('#808080')
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1.5)
      .padding({ left: this.horizontalPadding })

      // Divider
      Divider()
        .vertical(true)
        .height(this.dividerHeight)
        .color('#E0E0E0')
        .strokeWidth(1)

      // Details Column
      Column() {
        SettingItemSmall({ label: "ISO", value: this.iso })
        
        Blank().height(16)
        
        SettingItemSmall({ label: "SHUTTER", value: this.shutter })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
      .padding({ left: this.horizontalPadding })
    }
    .width('100%')
    .height(this.cardHeight)
    .backgroundColor('#F8F8F8')
    .borderRadius(this.cornerRadius)
    .border({ width: 1, color: '#EEEEEE' })
  }
}

// Setting Item Small
@Component
struct SettingItemSmall {
  private label: string = "";
  private value: string = "";

  build() {
    Column() {
      Text(this.value)
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor('#000000')
      
      Text(this.label)
        .fontSize(10)
        .fontWeight(FontWeight.Bold)
        .fontColor('#808080')
    }
    .alignItems(HorizontalAlign.Start)
  }
}

// ISO Selector
@Component
struct IsoSelector {
  private isoValues: string[] = ["100", "200", "400", "800", "1600", "3200"];
  private currentIso: string = "400";
  private onIsoSelected: (iso: string) => void = () => {};

  private itemWidth: number = 60;
  private itemHeight: number = 36;
  private cornerRadius: number = 50;
  private horizontalSpacing: number = 12;

  build() {
    Column() {
      Text("Film Stock ISO")
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor('#000000')
        .padding({ bottom: 12 })
      
      Scroll() {
        Row({ space: this.horizontalSpacing }) {
          ForEach(this.isoValues, (iso: string) => {
            Text(iso)
              .fontSize(13)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.currentIso === iso ? '#FFFFFF' : '#000000')
              .width(this.itemWidth)
              .height(this.itemHeight)
              .textAlign(TextAlign.Center)
              .backgroundColor(this.currentIso === iso ? '#000000' : Color.Transparent)
              .borderRadius(this.cornerRadius)
              .border({ width: 1, color: this.currentIso === iso ? '#000000' : '#E0E0E0' })
              .onClick(() => {
                this.onIsoSelected(iso);
              })
          })
        }
      }
      .scrollable(ScrollDirection.Horizontal)
      .scrollBar(BarState.Off)
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
  }
}

// Aperture Control
@Component
struct ApertureControl {
  @Prop value: number = 2.8;
  private onChange: (val: number) => void = () => {};

  private iconSize: number = 16;
  private trackHeight: number = 2;
  private thumbDiameter: number = 28;

  build() {
    Column() {
      Row() {
        Text("Aperture Control")
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#000000')
        
        Blank()

        Text("⚙")
          .fontSize(this.iconSize)
          .fontColor('#808080')
      }
      .width('100%')

      Blank().height(8)

      // Custom Slider Track
      Stack({ alignContent: Alignment.Start }) {
        // Inactive Track
        Column()
          .width('100%')
          .height(this.trackHeight)
          .backgroundColor('#E0E0E0')
          .borderRadius(this.trackHeight)

        // Active Track
        Column()
          .width(`${((this.value - 1.4) / (16.0 - 1.4)) * 100}%`)
          .height(this.trackHeight)
          .backgroundColor('#000000')
          .borderRadius(this.trackHeight)

        // Thumb
        Row()
          .width(this.thumbDiameter)
          .height(this.thumbDiameter)
          .backgroundColor('#000000')
          .borderRadius(this.thumbDiameter / 2)
          .shadow({ radius: 2, color: 'rgba(0,0,0,0.25)' })
          .margin({ left: `${((this.value - 1.4) / (16.0 - 1.4)) * 100}%` })
          .markAnchor({ x: this.thumbDiameter / 2, y: 0 })
      }
      .width('100%')
      .height(this.thumbDiameter) // Fixed: Removed invalid .alignItems(VerticalAlign.Center) from StackAttribute

      // Actual Slider for interaction (Transparent)
      Slider({
        value: this.value,
        min: 1.4,
        max: 16.0,
        step: (16.0 - 1.4) / 20.0,
        style: SliderStyle.OutSet
      })
        .blockColor(Color.Transparent)
        .trackColor(Color.Transparent)
        .selectedColor(Color.Transparent)
        .width('100%')
        .height(this.thumbDiameter)
        .position({ x: 0, y: 0 })
        .opacity(0.01) // Almost invisible but interactive
        .onChange((val: number, mode: SliderChangeMode) => {
          this.onChange(val);
        })

      Row() {
        Text("f/1.4")
          .fontSize(12)
          .fontColor('#808080')
        
        Blank()

        Text("f/16")
          .fontSize(12)
          .fontColor('#808080')
      }
      .width('100%')
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
  }
}

// Shutter Speed Control
@Component
struct ShutterSpeedControl {
  private speeds: string[] = [];
  private selectedIndex: number = 0;
  private onSelect: (index: number) => void = () => {};

  build() {
    Column() {
      Text("Shutter Speed")
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor('#000000')
        .padding({ bottom: 12 })
      
      Row() {
        SpeedOption({
          text: this.selectedIndex > 0 ? this.speeds[this.selectedIndex - 1] : "-",
          isSelected: false,
          onAction: () => {
            if (this.selectedIndex > 0) {
              this.onSelect(this.selectedIndex - 1);
            }
          }
        })
        
        SpeedOption({
          text: this.speeds[this.selectedIndex],
          isSelected: true,
          onAction: () => {}
        })
        
        SpeedOption({
          text: this.selectedIndex < this.speeds.length - 1 ? this.speeds[this.selectedIndex + 1] : "-",
          isSelected: false,
          onAction: () => {
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
    .width('100%')
  }
}

// Speed Option
@Component
struct SpeedOption {
  private text: string = "";
  private isSelected: boolean = false;
  private onAction: () => void = () => {}; // Fixed: Renamed from onClick to onAction to avoid conflict

  private itemWidth: number = 100;
  private itemHeight: number = 50;
  private cornerRadius: number = 12;

  build() {
    Text(this.text)
      .fontSize(this.isSelected ? 22 : 16)
      .fontWeight(this.isSelected ? FontWeight.Bold : FontWeight.Normal)
      .fontColor(this.isSelected ? '#000000' : '#E0E0E0')
      .width(this.itemWidth)
      .height(this.itemHeight)
      .textAlign(TextAlign.Center)
      .backgroundColor(this.isSelected ? '#F0F0F0' : Color.Transparent)
      .borderRadius(this.cornerRadius)
      .onClick(() => {
        if (!this.isSelected && this.text !== "-") {
          this.onAction();
        }
      })
  }
}

// Log Shot Button
@Component
struct LogShotButton {
  private buttonHeight: number = 56;
  private cornerRadius: number = 12;
  private iconBoxSize: number = 24;
  private iconSize: number = 16;

  build() {
    Button() {
      Row() {
        Stack() {
          Circle({ width: this.iconBoxSize, height: this.iconBoxSize })
            .fill(Color.White)
          
          Text("+")
            .fontSize(this.iconSize)
            .fontColor('#000000')
            .fontWeight(FontWeight.Bold)
        }
        .width(this.iconBoxSize)
        .height(this.iconBoxSize)

        Text("LOG EXPOSURE")
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FFFFFF')
          .letterSpacing(1)
          .margin({ left: 12 })
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .height(this.buttonHeight)
    .backgroundColor('#000000')
    .borderRadius(this.cornerRadius)
    .onClick(() => {})
  }
}