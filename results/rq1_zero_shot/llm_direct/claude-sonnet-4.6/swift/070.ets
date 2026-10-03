import { LengthUnit } from '@ohos.arkui.node';

// MARK: - Color Palette
const LWColors = {
  background: '#FBFBFE',
  cardBg: '#F5F3FD',
  headerCircle: '#EEE9FC',
  purpleActive: '#8B5CF6',
  purpleInactive: '#EBE7F6',
  textInactive: '#1F2937',
  buttonPink: '#F4AECF',
  buttonText: '#2D0D1B',
  textDark: '#111827',
  textGray: '#6B7280',
  border: '#C4B5FD',
  stepActiveCircle: '#A07CFF',
}

// MARK: - Step Data Model
interface StepData {
  step: string;
  title: string;
  subtitle: string;
  btnText: string;
  isActive: boolean;
  isLast: boolean;
}

// MARK: - Header Component
@Component
struct HeaderView {
  build() {
    Row() {
      // Left Circle
      Circle()
        .width(44)
        .height(44)
        .fill(LWColors.headerCircle)

      Blank()

      // Title Block
      Column({ space: 2 }) {
        Text('LeaseWizard')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')

        Text('Guided handoff')
          .fontSize(13)
          .fontWeight(FontWeight.Normal)
          .fontColor(LWColors.textGray)
      }

      Blank()

      // Right Circle
      Circle()
        .width(44)
        .height(44)
        .fill(LWColors.headerCircle)
    }
    .width('100%')
    .padding({ left: 20, right: 20 })
  }
}

// MARK: - Step Row Component
@Component
struct StepRow {
  step: string = '';
  title: string = '';
  subtitle: string = '';
  btnText: string = '';
  isActive: boolean = false;
  isLast: boolean = false;

  build() {
    Row({ space: 16 }) {
      // Indicator Column
      Column({ space: 0 }) {
        // Step Circle
        Stack() {
          Circle()
            .width(32)
            .height(32)
            .fill(this.isActive ? LWColors.stepActiveCircle : LWColors.purpleInactive)

          Text(this.step)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.isActive ? '#000000' : LWColors.textDark)
        }
        .width(32)
        .height(32)

        // Vertical Connecting Line
        if (!this.isLast) {
          Rect()
            .width(2)
            .height(40)
            .fill(LWColors.headerCircle)
        }
      }
      .width(32)
      .alignItems(HorizontalAlign.Center)

      // Text Content
      Column({ space: 2 }) {
        Text(this.title)
          .fontSize(17)
          .fontWeight(FontWeight.Medium)
          .fontColor(LWColors.textDark)
          .margin({ top: 4 })

        Text(this.subtitle)
          .fontSize(15)
          .fontWeight(FontWeight.Normal)
          .fontColor(LWColors.textGray)

        Blank().height(24)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      // Action Button
      Button(this.btnText)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(LWColors.buttonText)
        .width(60)
        .height(36)
        .backgroundColor(LWColors.buttonPink)
        .borderRadius(8)
        .margin({ top: 2 })
    }
    .width('100%')
    .alignItems(VerticalAlign.Top)
  }
}

// MARK: - Custom Text Field Component
@Component
struct CustomTextField {
  label: string = '';
  text: string = '';

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // Input Field Box
      Row() {
        Text(this.text)
          .fontSize(18)
          .fontWeight(FontWeight.Normal)
          .fontColor(LWColors.textDark)
          .layoutWeight(1)
      }
      .width('100%')
      .padding({ top: 16, bottom: 16, left: 16, right: 16 })
      .border({
        width: 1,
        color: LWColors.border,
        radius: 12,
        style: BorderStyle.Solid
      })

      // Floating Label
      Text(this.label)
        .fontSize(14)
        .fontWeight(FontWeight.Normal)
        .fontColor(LWColors.textGray)
        .padding({ left: 4, right: 4 })
        .backgroundColor(LWColors.cardBg)
        .offset({ x: 12, y: -10 })
    }
    .width('100%')
  }
}

// MARK: - Steps Section Component
@Component
struct StepsSection {
  private steps: StepData[] = [
    {
      step: '1',
      title: 'Profile',
      subtitle: 'Tenant basics',
      btnText: 'Edit',
      isActive: true,
      isLast: false
    },
    {
      step: '2',
      title: 'Income',
      subtitle: 'Proof details',
      btnText: 'Edit',
      isActive: true,
      isLast: false
    },
    {
      step: '3',
      title: 'References',
      subtitle: 'Upload letters',
      btnText: 'Go',
      isActive: false,
      isLast: false
    },
    {
      step: '4',
      title: 'Summary',
      subtitle: 'Confirm submission',
      btnText: 'Go',
      isActive: false,
      isLast: true
    }
  ];

  build() {
    Column({ space: 20 }) {
      Text('Steps')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor(LWColors.textDark)
        .alignSelf(ItemAlign.Start)

      Column({ space: 0 }) {
        ForEach(this.steps, (item: StepData) => {
          StepRow({
            step: item.step,
            title: item.title,
            subtitle: item.subtitle,
            btnText: item.btnText,
            isActive: item.isActive,
            isLast: item.isLast
          })
        })
      }
      .width('100%')
    }
    .width('100%')
    .padding(24)
    .backgroundColor(LWColors.cardBg)
    .borderRadius(24)
    .alignItems(HorizontalAlign.Start)
  }
}

// MARK: - Form Section Component
@Component
struct FormSection {
  build() {
    Column({ space: 25 }) {
      Text('Form')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor(LWColors.textDark)
        .alignSelf(ItemAlign.Start)

      CustomTextField({ label: 'Full name', text: 'Avery Tenant' })

      CustomTextField({ label: 'Contact', text: 'avery@example.com' })

      Blank().height(10)
    }
    .width('100%')
    .padding(24)
    .backgroundColor(LWColors.cardBg)
    .borderRadius(24)
    .alignItems(HorizontalAlign.Start)
  }
}

// MARK: - Main Content View
@Entry
@Component
struct ContentView {
  build() {
    Column({ space: 0 }) {
      // Header
      HeaderView()
        .margin({ top: 10, bottom: 10 })

      // Scrollable Content
      Scroll() {
        Column({ space: 24 }) {
          StepsSection()
          FormSection()
        }
        .width('100%')
        .padding({ left: 16, right: 16, bottom: 40 })
      }
      .scrollBar(BarState.Off)
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(LWColors.background)
  }
}