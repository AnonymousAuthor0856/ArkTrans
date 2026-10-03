import { 
  Length, 
  ResourceStr, 
  CommonType 
} from '@ohos.arkui';

// MARK: - 1. Entry Point
@Entry
@Component
struct LeaseWizardApp {
  build() {
    Column() {
      ContentView()
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.lwBackground'))
  }
}

// MARK: - 2. Color Palette
class ColorPalette {
  static readonly lwBackground: string = '#FBFBFE';
  static readonly lwCardBg: string = '#F5F3FD';
  static readonly lwHeaderCircle: string = '#EEE9FC';
  static readonly lwPurpleActive: string = '#8B5CF6';
  static readonly lwPurpleInactive: string = '#EBE7F6';
  static readonly lwTextInactive: string = '#1F2937';
  static readonly lwButtonPink: string = '#F4AECF';
  static readonly lwButtonText: string = '#2D0D1B';
  static readonly lwTextDark: string = '#111827';
  static readonly lwTextGray: string = '#6B7280';
  static readonly lwBorder: string = '#C4B5FD';
}

// MARK: - 3. Main Content View
@Component
export struct ContentView {
  build() {
    Column() {
      // Header
      HeaderView()
        .margin({ top: 10, bottom: 10 })

      // Scrollable Content
      Scroll() {
        Column() {
          // Section 1: Steps Container
          Column() {
            Text('Steps')
              .fontSize(22)
              .fontWeight(FontWeight.Bold)
              .fontColor(ColorPalette.lwTextDark)
              .margin({ bottom: 20 })
              .alignSelf(ItemAlign.Start)

            // Steps List
            Column() {
              StepRow({ step: '1', title: 'Profile', subtitle: 'Tenant basics', btnText: 'Edit', isActive: true, isLast: false })
              StepRow({ step: '2', title: 'Income', subtitle: 'Proof details', btnText: 'Edit', isActive: true, isLast: false })
              StepRow({ step: '3', title: 'References', subtitle: 'Upload letters', btnText: 'Go', isActive: false, isLast: false })
              StepRow({ step: '4', title: 'Summary', subtitle: 'Confirm submission', btnText: 'Go', isActive: false, isLast: true })
            }
          }
          .padding(24)
          .backgroundColor(ColorPalette.lwCardBg)
          .borderRadius(24)
          .margin({ bottom: 24 })

          // Section 2: Form Container
          Column() {
            Text('Form')
              .fontSize(22)
              .fontWeight(FontWeight.Bold)
              .fontColor(ColorPalette.lwTextDark)
              .margin({ bottom: 25 })
              .alignSelf(ItemAlign.Start)

            CustomTextField({ label: 'Full name', text: 'Avery Tenant' })
            CustomTextField({ label: 'Contact', text: 'avery@example.com' })
          }
          .padding(24)
          .backgroundColor(ColorPalette.lwCardBg)
          .borderRadius(24)
        }
        .padding({ left: 16, right: 16, bottom: 40 })
      }
      .scrollBar(BarState.Off)
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(ColorPalette.lwBackground)
  }
}

// MARK: - 4. Components

@Component
struct HeaderView {
  build() {
    Row() {
      // Left Circle
      Circle({ width: 44, height: 44 })
        .fill(ColorPalette.lwHeaderCircle)

      // Spacer
      Blank()
        .layoutWeight(1)

      // Title Block
      Column() {
        Text('LeaseWizard')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
        Text('Guided handoff')
          .fontSize(13)
          .fontWeight(FontWeight.Normal)
          .fontColor(ColorPalette.lwTextGray)
          .margin({ top: 2 })
      }

      // Spacer
      Blank()
        .layoutWeight(1)

      // Right Circle
      Circle({ width: 44, height: 44 })
        .fill(ColorPalette.lwHeaderCircle)
    }
    .padding({ left: 20, right: 20 })
  }
}

@Component
struct StepRow {
  private step: string = '';
  private title: string = '';
  private subtitle: string = '';
  private btnText: string = '';
  private isActive: boolean = false;
  private isLast: boolean = false;

  build() {
    Row() {
      // Indicator Column
      Column() {
        // Circle Indicator
        Stack() {
          Text(this.step)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.isActive ? '#000000' : ColorPalette.lwTextDark)
        }
        .width(32)
        .height(32)
        .borderRadius(16)
        .backgroundColor(this.isActive ? '#A07CFF' : ColorPalette.lwPurpleInactive)

        // Vertical Connecting Line
        if (!this.isLast) {
          Line()
            .width(2)
            .height(40)
            .backgroundColor(ColorPalette.lwHeaderCircle)
            .margin({ top: 4 })
        }
      }
      .width(32)
      .alignItems(HorizontalAlign.Center)

      // Text Content
      Column() {
        Text(this.title)
          .fontSize(17)
          .fontWeight(FontWeight.Medium)
          .fontColor(ColorPalette.lwTextDark)
          .margin({ top: 4 })
          .alignSelf(ItemAlign.Start)

        Text(this.subtitle)
          .fontSize(15)
          .fontWeight(FontWeight.Normal)
          .fontColor(ColorPalette.lwTextGray)
          .margin({ top: 2 })
          .alignSelf(ItemAlign.Start)

        // Bottom spacing
          .height(24)
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      .margin({ left: 16 })

      // Action Button
      Button(this.btnText)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(ColorPalette.lwButtonText)
        .width(60)
        .height(36)
        .backgroundColor(ColorPalette.lwButtonPink)
        .borderRadius(8)
        .margin({ top: 2 })
    }
    .alignItems(VerticalAlign.Top)
  }
}

@Component
struct CustomTextField {
  private label: string = '';
  private text: string = '';

  build() {
    // The Input Field Box
    Stack({ alignContent: Alignment.TopStart }) {
      Row() {
        Text(this.text)
          .fontSize(18)
          .fontWeight(FontWeight.Normal)
          .fontColor(ColorPalette.lwTextDark)
          .margin({ left: 16 })
        Blank()
      }
      .width('100%')
      .padding({ top: 16, bottom: 16 })
      .border({ width: 1, color: ColorPalette.lwBorder, radius: 12 })

      // The Floating Label
      Text(this.label)
        .fontSize(14)
        .fontWeight(FontWeight.Normal)
        .fontColor(ColorPalette.lwTextGray)
        .padding({ left: 4, right: 4 })
        .backgroundColor(ColorPalette.lwCardBg)
        .margin({ left: 12, top: -10 })
    }
    .width('100%')
    .margin({ bottom: 25 })
  }
}