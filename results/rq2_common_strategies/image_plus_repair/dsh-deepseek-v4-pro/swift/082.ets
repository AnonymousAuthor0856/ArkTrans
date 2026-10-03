// 082.swift -> 082.ets
// SwiftUI Smart Home screen translated to ArkTS (HarmonyOS ArkUI).
// The SwiftUI app/scene scaffolding (@main App + WindowGroup + ContentView)
// maps to a single @Entry page, which is the ArkUI application entry point.

// MARK: - Models

@Observed
class DeviceItem {
  id: string;
  name: string;
  status: string;
  icon: string;
  isActive: boolean;
  private static idCounter: number = 0;

  constructor(name: string, status: string, icon: string, isActive: boolean) {
    DeviceItem.idCounter += 1;
    // Swift's `let id = UUID()` is replaced by a monotonic counter so every
    // DeviceItem keeps a unique Identifiable id.
    this.id = 'device_' + DeviceItem.idCounter.toString();
    this.name = name;
    this.status = status;
    this.icon = icon;
    this.isActive = isActive;
  }
}

// SF Symbol names (SwiftUI Image(systemName:)) have no direct HarmonyOS
// equivalent, so they are rendered as emoji while the source icon strings
// are kept intact.
function iconEmoji(icon: string): string {
  if (icon === 'house.fill') { return '🏠'; }
  if (icon === 'lock.fill') { return '🔒'; }
  if (icon === 'star.fill') { return '⭐'; }
  if (icon === 'location.circle.fill') { return '📍'; }
  if (icon === 'info.circle.fill') { return 'ℹ️'; }
  if (icon === 'bell.fill') { return '🔔'; }
  if (icon === 'gearshape.fill') { return '⚙️'; }
  if (icon === 'person.circle.fill') { return '👤'; }
  return '•';
}

// MARK: - Main Screen

@Entry
@Component
struct SmartHomeApp {
  // Colors matching Android theme
  private primaryColor: string = '#4A6572'; // #4A6572
  private screenBgColor: string = '#F5F6F8'; // #F5F6F8

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        Scroll() {
          Column({ space: 0 }) {
            Blank().height(24)

            HeaderSection({ primaryColor: this.primaryColor })
              .padding({ left: 24, right: 24 })

            Blank().height(32)

            EnvironmentSummary()
              .padding({ left: 24, right: 24 })

            Blank().height(32)

            DevicesGrid({ primaryColor: this.primaryColor })
              .padding({ left: 24, right: 24 })

            // Extra padding for bottom bar
            Blank().height(100)
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)
        }
        .scrollBar(BarState.Off)
        .width('100%')
        .height('100%')
      }
      .width('100%')
      .height('100%')

      SmartHomeBottomBar({ primaryColor: this.primaryColor })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.screenBgColor)
  }
}

// MARK: - Components

@Component
struct HeaderSection {
  @Prop primaryColor: string = '#4A6572';

  build() {
    Row() {
      Column({ space: 4 }) {
        Text('Welcome Home,')
          .fontSize(16)
          .fontColor('#999999')
        Text('Alex Johnson')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Stack() {
        Circle({ width: 48, height: 48 })
          .fill(this.primaryColor)
          .opacity(0.1)

        Text(iconEmoji('person.circle.fill'))
          .fontSize(20)
          .fontColor(this.primaryColor)
      }
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct EnvironmentSummary {
  build() {
    /*
     * Temperature card only for this example view layout based on provided image
     * The Android code has two cards in a row (Temp & Humidity),
     * but image 5 shows one wide card for Temperature.
     * Following the visual reference (image 5) primarily, but keeping code structure flexible.
     * Image 5 shows "Temperature 24°C Comfortable" in a single large blue card.
     *
     * However, checking the Android code provided (file 5.txt), it actually implements:
     * Row with EnvironmentCard(Temp) and EnvironmentCard(Humidity).
     * BUT image 5 shows a large blue card at top.
     * Wait, image 5 top section corresponds to "EnvironmentSummary" but styled differently in the screenshot vs code?
     * Let's look closely at Image 5.
     * It shows "Temperature" label, "24°C", "Comfortable". It spans full width.
     * The Android code provided has two smaller cards.
     * Requirement: "Button sizes, spacing... match Android version".
     * Requirement: "Refer to provided final UI reference image to validate layout consistency".
     * Image 5 shows a single big blue card. Android code shows 2 small cards.
     * Usually visual reference takes precedence for layout.
     * However, if I must port the Android CODE, I should output what the code does?
     * "Migrate Android Kotlin UI code to iOS Swift code". This implies faithful translation of the code logic.
     * BUT "Refer to provided final UI reference image".
     * Image 5 shows: Big blue card "Temperature 24C Comfortable".
     * Android code 'EnvironmentSummary' calls 'EnvironmentCard' twice.
     * Actually, looking at image 5 again... no, that IS what the Android code produces?
     * Wait, the Android code produces 'Row { EnvironmentCard(...), Spacer, EnvironmentCard(...) }'.
     * This would be two columns.
     * Image 5 shows one big card spanning width.
     * Let's re-read the Android code carefully.
     * It puts them in a Row with 'Arrangement.SpaceBetween'.
     * If I implement the Android code exactly, I get two cards.
     * If I follow Image 5, I get one card.
     * I will follow the visual reference (Image 5) for the card style since it's the "final UI reference",
     * but I will verify if the code matches.
     * Actually, the provided Android code 'EnvironmentSummary' puts TWO cards side-by-side.
     * Image 5 shows ONE card.
     * It is possible the Android code provided doesn't perfectly match Image 5, or I am misinterpreting.
     * Let's look at Image 5 again. "Temperature" ... "24°C" ... "Comfortable".
     * It looks like a single wide card with blue background.
     * The Android code uses 'Color(0xFFE3F2FD)' (light blue) for the first card.
     * I will implement the layout as visually seen in Image 5 to satisfy "validate layout consistency",
     * effectively adapting the code to match the visual.
     * Actually, looking closer at Image 5, it seems to be just the Temperature card?
     * Wait, maybe the Humidity card is off-screen or the code is different?
     * I will implement the visual from Image 5 which is a single large card.
     * Code-wise, I'll adapt to make it look like the image.
     *
     * CORRECTION: I will implement the logic of the Android code, but style it to look good.
     * If the Android code renders two cards, I will render two cards.
     * But if Image 5 only shows one, there's a conflict.
     * Conflict resolution: Code is the source of truth for functionality, Image for style.
     * If code has 2 items, I should probably show 2 items.
     * BUT Image 5 is titled "Welcome Home, Alex Johnson".
     * It shows "Temperature 24C".
     * It shows "My Devices" with 4 items.
     * The Android code has 6 items in the grid.
     * The Image has 4 items in the grid.
     * It seems the Android Code provided corresponds to a slightly different version or the user provided generic code.
     * I will strictly follow the ANDROID CODE logic (2 cards, 6 devices) but style them as close as possible to the general aesthetic of Image 5.
     * Actually, looking at Image 5's top card: Blue background, white text.
     * Android code: Light blue background ('Color(0xFFE3F2FD)'), Dark blue text ('Color(0xFF1565C0)').
     * This matches.
     * So I will implement the 2-card row from the Android code.
     */
    Row({ space: 16 }) {
      EnvironmentCard({
        title: 'Temperature',
        value: '24°C',
        subtitle: 'Comfortable',
        bgColor: '#E3F2FD', // #E3F2FD
        textColor: '#1565C0' // #1565C0
      })
      .layoutWeight(1)

      EnvironmentCard({
        title: 'Humidity',
        value: '45%',
        subtitle: 'Normal',
        bgColor: '#E8F5E9', // #E8F5E9
        textColor: '#2E7D32' // #2E7D32
      })
      .layoutWeight(1)
    }
    .width('100%')
  }
}

@Component
struct EnvironmentCard {
  @Prop title: string = '';
  @Prop value: string = '';
  @Prop subtitle: string = '';
  @Prop bgColor: string = '#FFFFFF';
  @Prop textColor: string = '#000000';

  build() {
    Column() {
      Text(this.title)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.textColor)
        .opacity(0.8)

      Blank()

      Column({ space: 0 }) {
        Text(this.value)
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.textColor)
        Text(this.subtitle)
          .fontSize(11)
          .fontColor(this.textColor)
          .opacity(0.7)
      }
      .alignItems(HorizontalAlign.Start)
    }
    .alignItems(HorizontalAlign.Start)
    .padding(16)
    .width('100%')
    .height(100)
    .backgroundColor(this.bgColor)
    .borderRadius(16)
  }
}

@Component
struct DevicesGrid {
  @Prop primaryColor: string = '#4A6572';

  // Data from Android code
  private devices: DeviceItem[] = [
    new DeviceItem('Living Room', '2 Lights On', 'house.fill', true),
    new DeviceItem('Smart Lock', 'Locked', 'lock.fill', true),
    new DeviceItem('Bedroom AC', '22°C', 'star.fill', false),
    new DeviceItem('Router', 'Online', 'location.circle.fill', true),
    new DeviceItem('Kitchen', 'All Off', 'info.circle.fill', false),
    new DeviceItem('Corridor', 'Motion Detected', 'bell.fill', true)
  ];

  build() {
    Column({ space: 16 }) {
      Text('My Devices')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor('#000000')

      Grid() {
        ForEach(this.devices, (device: DeviceItem) => {
          GridItem() {
            DeviceCard({ device: device, primaryColor: this.primaryColor })
          }
        }, (device: DeviceItem) => device.id)
      }
      .columnsTemplate('1fr 1fr')
      .columnsGap(16)
      .rowsGap(16)
      .width('100%')
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
  }
}

@Component
struct DeviceCard {
  @ObjectLink device: DeviceItem;
  @Prop primaryColor: string = '#4A6572';
  @State isChecked: boolean = false;

  aboutToAppear(): void {
    this.isChecked = this.device.isActive;
  }

  build() {
    Column() {
      Row() {
        Stack() {
          Circle({ width: 36, height: 36 })
            .fill(this.isChecked ? '#33FFFFFF' : '#F0F0F0')

          Text(iconEmoji(this.device.icon))
            .fontSize(14) // approx 20dp visual
            .fontColor(this.isChecked ? '#FFFFFF' : '#999999')
        }

        Blank()

        Toggle({ type: ToggleType.Switch, isOn: this.isChecked })
          .onChange((isOn: boolean) => {
            this.isChecked = isOn;
          })
          .selectedColor('#66FFFFFF') // Approximating the style
          .scale({ x: 0.7, y: 0.7 })
      }
      .width('100%')

      Blank()

      Column({ space: 4 }) {
        Text(this.device.name)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.isChecked ? '#FFFFFF' : '#000000')

        Text(this.isChecked ? 'On' : 'Off')
          .fontSize(11)
          .fontColor(this.isChecked ? '#B3FFFFFF' : '#999999')
      }
      .alignItems(HorizontalAlign.Start)
    }
    .alignItems(HorizontalAlign.Start)
    .padding(16)
    .height(140)
    .backgroundColor(this.isChecked ? this.primaryColor : '#FFFFFF')
    .borderRadius(20)
    .shadow({
      radius: 8,
      color: this.isChecked ? '#4D4A6572' : '#0D000000',
      offsetX: 0,
      offsetY: 4
    })
  }
}

@Component
struct SmartHomeBottomBar {
  @Prop primaryColor: string = '#4A6572';

  build() {
    Stack({ alignContent: Alignment.Top }) {
      // Shadow layer
      Column()
        .width('100%')
        .height(80)
        .backgroundColor('#FFFFFF')
        .borderRadius({ topLeft: 24, topRight: 24 })
        .shadow({ radius: 4, color: '#0D000000', offsetX: 0, offsetY: -2 })

      Row() {
        Blank()
        NavBarItem({ icon: 'house.fill', label: 'Home', isSelected: true, primaryColor: this.primaryColor })
        Blank()
        NavBarItem({ icon: 'star.fill', label: 'Scenes', isSelected: false, primaryColor: this.primaryColor })
        Blank()
        NavBarItem({ icon: 'gearshape.fill', label: 'Settings', isSelected: false, primaryColor: this.primaryColor })
        Blank()
      }
      .width('100%')
      .padding({ top: 16 })
    }
    .width('100%')
    .height(80)
  }
}

@Component
struct NavBarItem {
  @Prop icon: string = '';
  @Prop label: string = '';
  @Prop isSelected: boolean = false;
  @Prop primaryColor: string = '#4A6572';

  build() {
    Column({ space: 4 }) {
      Stack() {
        if (this.isSelected) {
          Column()
            .width(64)
            .height(32)
            .backgroundColor(this.primaryColor)
            .opacity(0.1)
            .borderRadius(16)
        }

        Text(iconEmoji(this.icon))
          .fontSize(24)
          .fontColor(this.isSelected ? this.primaryColor : '#999999')
      }

      Text(this.label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.isSelected ? this.primaryColor : '#999999')
    }
  }
}

// MARK: - Helper for Corners
// SwiftUI's RoundedCorner Shape + cornerRadius(_:corners:) extension are
// iOS-only (UIRectCorner / UIBezierPath). ArkUI's borderRadius already
// supports per-corner rounding (e.g. borderRadius({ topLeft, topRight })),
// so no custom Shape helper is required.
