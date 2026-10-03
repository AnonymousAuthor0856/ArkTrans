// MARK: - 1. Entry Point
@Entry
@Component
struct LeaseWizardApp {
  build() {
    Stack() {
      ContentView()
    }
    .width('100%')
    .height('100%')
  }
}

// MARK: - 2. Color Palette
// Backgrounds
const lwBackground = '#FBFBFE'
const lwCardBg = '#F5F3FD' // Pale lavender card
const lwHeaderCircle = '#EEE9FC'

// Accents
const lwPurpleActive = '#8B5CF6' // Vibrant purple
const lwPurpleInactive = '#EBE7F6' // Muted lavender
const lwTextInactive = '#1F2937'
const lwButtonPink = '#F4AECF' // Soft pink
const lwButtonText = '#2D0D1B'

// Text & Borders
const lwTextDark = '#111827'
const lwTextGray = '#6B7280'
const lwBorder = '#C4B5FD'

// MARK: - 3. Main Content View
@Component
struct ContentView {
  build() {
    Stack() {
      // Global Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(lwBackground)

      Column() {
        // Header
        HeaderView()
          .padding({ top: 10, bottom: 10 })

        Scroll() {
          Column({ space: 24 }) {
            // Section 1: Steps Container
            Column({ space: 20 }) {
              Text('Steps')
                .fontSize(22)
                .fontWeight(FontWeight.Bold)
                .fontColor(lwTextDark)

              Column({ space: 0 }) {
                StepRow({
                  step: '1',
                  title: 'Profile',
                  subtitle: 'Tenant basics',
                  btnText: 'Edit',
                  isActive: true,
                  isLast: false
                })

                StepRow({
                  step: '2',
                  title: 'Income',
                  subtitle: 'Proof details',
                  btnText: 'Edit',
                  isActive: true,
                  isLast: false
                })

                StepRow({
                  step: '3',
                  title: 'References',
                  subtitle: 'Upload letters',
                  btnText: 'Go',
                  isActive: false,
                  isLast: false
                })

                StepRow({
                  step: '4',
                  title: 'Summary',
                  subtitle: 'Confirm submission',
                  btnText: 'Go',
                  isActive: false,
                  isLast: true
                })
              }
            }
            .alignItems(HorizontalAlign.Start)
            .padding(24)
            .backgroundColor(lwCardBg)
            .borderRadius(24)

            // Section 2: Form Container
            Column({ space: 25 }) {
              Text('Form')
                .fontSize(22)
                .fontWeight(FontWeight.Bold)
                .fontColor(lwTextDark)

              // Custom Floating Label Inputs
              CustomTextField({ label: 'Full name', text: 'Avery Tenant' })

              CustomTextField({ label: 'Contact', text: 'avery@example.com' })

              // Spacer to ensure bottom padding visible in scroll
              Blank().height(10)
            }
            .alignItems(HorizontalAlign.Start)
            .padding(24)
            .backgroundColor(lwCardBg)
            .borderRadius(24)
          }
          .width('100%')
          .padding({ left: 16, right: 16, bottom: 40 })
        }
        .scrollBar(BarState.Off)
        .align(Alignment.TopStart)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    // Requirement: Status bar hidden
  }
}

// MARK: - 4. Components

@Component
struct HeaderView {
  build() {
    Row() {
      // Left Circle
      Circle()
        .fill(lwHeaderCircle)
        .width(44)
        .height(44)

      Blank()

      // Title Block
      Column({ space: 2 }) {
        Text('LeaseWizard')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
        Text('Guided handoff')
          .fontSize(13)
          .fontWeight(FontWeight.Regular)
          .fontColor(lwTextGray)
      }

      Blank()

      // Right Circle
      Circle()
        .fill(lwHeaderCircle)
        .width(44)
        .height(44)
    }
    .width('100%')
    .padding({ left: 20, right: 20 })
  }
}

@Component
struct StepRow {
  step: string = ''
  title: string = ''
  subtitle: string = ''
  btnText: string = ''
  isActive: boolean = false
  isLast: boolean = false

  build() {
    Row({ space: 16 }) {
      // Indicator Column
      Column({ space: 0 }) {
        Stack() {
          Circle()
            .fill(this.isActive ? '#A07CFF' : lwPurpleInactive)
            .width(32)
            .height(32)

          Text(this.step)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.isActive ? '#000000' : lwTextDark)
        }
        .width(32)
        .height(32)

        // Vertical Connecting Line
        if (!this.isLast) {
          Rect()
            .fill(lwHeaderCircle) // Subtle line color
            .width(2)
            .constraintSize({ minHeight: 40 }) // Ensures spacing between rows
        }
      }
      .width(32) // Fixed width for alignment
      .alignItems(HorizontalAlign.Center)

      // Text Content
      Column({ space: 2 }) {
        Text(this.title)
          .fontSize(17)
          .fontWeight(FontWeight.Medium) // semibold
          .fontColor(lwTextDark)
          .padding({ top: 4 }) // Align visually with circle

        Text(this.subtitle)
          .fontSize(15)
          .fontWeight(FontWeight.Regular)
          .fontColor(lwTextGray)

        Blank().height(24) // Bottom spacing
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      // Action Button
      Button() {
        Text(this.btnText)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(lwButtonText)
          .width(60)
          .height(36)
          .backgroundColor(lwButtonPink)
          .borderRadius(8)
      }
      .padding({ top: 2 }) // Align button with top text
      .onClick(() => {})
    }
    .alignItems(VerticalAlign.Top)
    .width('100%')
  }
}

@Component
struct CustomTextField {
  label: string = ''
  text: string = ''

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // The Input Field Box
      Row() {
        Text(this.text)
          .fontSize(18)
          .fontWeight(FontWeight.Regular)
          .fontColor(lwTextDark)
        Blank()
      }
      .padding({ top: 16, bottom: 16, left: 16, right: 16 })
      .border({ width: 1, color: lwBorder, radius: 12 })

      // The Floating Label
      Text(this.label)
        .fontSize(14)
        .fontWeight(FontWeight.Regular)
        .fontColor(lwTextGray)
        .padding({ left: 4, right: 4 })
        .backgroundColor(lwCardBg) // Masks the border behind the text
        .offset({ x: 12, y: -10 }) // Move up to intersect border
    }
    .width('100%')
  }
}

// MARK: - 5. Helper: Hex Color Initializer
// ArkUI accepts hex color strings directly (e.g. '#RRGGBB'), so the
// SwiftUI hex Color initializer is represented by the string constants above.
