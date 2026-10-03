import window from '@ohos.window';
import common from '@ohos.app.ability.common';

// MARK: - 2. Color Palette
class LwColors {
  static readonly background: string = '#FBFBFE';
  static readonly cardBg: string = '#F5F3FD';
  static readonly headerCircle: string = '#EEE9FC';
  static readonly purpleActive: string = '#8B5CF6';
  static readonly purpleInactive: string = '#EBE7F6';
  static readonly textInactive: string = '#1F2937';
  static readonly buttonPink: string = '#F4AECF';
  static readonly buttonText: string = '#2D0D1B';
  static readonly textDark: string = '#111827';
  static readonly textGray: string = '#6B7280';
  static readonly border: string = '#C4B5FD';
}

// MARK: - 1 / 3. Entry Point + Main Content
@Entry
@Component
struct ContentView {
  aboutToAppear(): void {
    const ctx = getContext(this) as common.UIAbilityContext;
    window.getLastWindow(ctx).then((win: window.Window) => {
      win.setWindowLayoutFullScreen(true);
      win.setWindowSystemBarEnable([]);
    }).catch(() => {
    });
  }

  // MARK: - 4. Components

  @Builder
  HeaderView() {
    Row() {
      // Left circle
      Column()
        .width(44)
        .height(44)
        .borderRadius(22)
        .backgroundColor(LwColors.headerCircle)

      // Title block
      Column() {
        Text('LeaseWizard')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
        Text('Guided handoff')
          .fontSize(13)
          .fontWeight(FontWeight.Normal)
          .fontColor(LwColors.textGray)
          .margin({ top: 2 })
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Center)

      // Right circle
      Column()
        .width(44)
        .height(44)
        .borderRadius(22)
        .backgroundColor(LwColors.headerCircle)
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
    .padding({ left: 20, right: 20, top: 10, bottom: 10 })
  }

  @Builder
  StepRow(step: string, title: string, subtitle: string, btnText: string, isActive: boolean, isLast: boolean) {
    Row() {
      // Indicator column
      Column() {
        Stack() {
          Column()
            .width(32)
            .height(32)
            .borderRadius(16)
            .backgroundColor(isActive ? LwColors.purpleActive : LwColors.purpleInactive)

          Text(step)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(isActive ? '#000000' : LwColors.textInactive)
        }
        .width(32)
        .height(32)

        // Vertical connecting line
        if (!isLast) {
          Column()
            .width(2)
            .height(40)
            .backgroundColor(LwColors.headerCircle)
        }
      }
      .width(32)
      .alignItems(HorizontalAlign.Center)

      // Text content
      Column() {
        Text(title)
          .fontSize(17)
          .fontWeight(FontWeight.Bold)
          .fontColor(LwColors.textDark)
          .margin({ top: 4 })

        Text(subtitle)
          .fontSize(15)
          .fontWeight(FontWeight.Normal)
          .fontColor(LwColors.textGray)
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
      .margin({ left: 16 })
      .padding({ bottom: 24 })

      // Action button
      Button(btnText)
        .type(ButtonType.Normal)
        .width(60)
        .height(36)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(LwColors.buttonText)
        .backgroundColor(LwColors.buttonPink)
        .borderRadius(8)
        .margin({ top: 2 })
    }
    .width('100%')
    .alignItems(VerticalAlign.Top)
  }

  @Builder
  StepsCard() {
    Column({ space: 20 }) {
      Text('Steps')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor(LwColors.textDark)

      Column() {
        this.StepRow('1', 'Profile', 'Tenant basics', 'Edit', true, false)
        this.StepRow('2', 'Income', 'Proof details', 'Edit', true, false)
        this.StepRow('3', 'References', 'Upload letters', 'Go', false, false)
        this.StepRow('4', 'Summary', 'Confirm submission', 'Go', false, true)
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding(24)
    .backgroundColor(LwColors.cardBg)
    .borderRadius(24)
  }

  @Builder
  CustomTextField(label: string, value: string) {
    Stack({ alignContent: Alignment.TopStart }) {
      // The input field box
      Row() {
        Text(value)
          .fontSize(18)
          .fontWeight(FontWeight.Normal)
          .fontColor(LwColors.textDark)
        Blank()
      }
      .width('100%')
      .padding({ top: 16, bottom: 16, left: 16, right: 16 })
      .border({ width: 1, color: LwColors.border, radius: 12 })

      // The floating label
      Text(label)
        .fontSize(14)
        .fontWeight(FontWeight.Normal)
        .fontColor(LwColors.textGray)
        .padding({ left: 4, right: 4 })
        .backgroundColor(LwColors.cardBg)
        .offset({ x: 12, y: -10 })
    }
    .width('100%')
  }

  @Builder
  FormCard() {
    Column({ space: 25 }) {
      Text('Form')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor(LwColors.textDark)

      this.CustomTextField('Full name', 'Avery Tenant')
      this.CustomTextField('Contact', 'avery@example.com')
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding(24)
    .backgroundColor(LwColors.cardBg)
    .borderRadius(24)
  }

  build() {
    Column() {
      this.HeaderView()

      Scroll() {
        Column({ space: 24 }) {
          this.StepsCard()
          this.FormCard()
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)
        .padding({ left: 16, right: 16, top: 0, bottom: 40 })
      }
      .width('100%')
      .layoutWeight(1)
      .align(Alignment.Top)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(LwColors.background)
  }
}