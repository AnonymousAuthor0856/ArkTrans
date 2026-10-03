// TeaBrewing.ets — HarmonyOS ArkTS (ArkUI) entry page

class TeaColors {
  static readonly primary: string = '#6D4C41';
  static readonly secondary: string = '#A1887F';
  static readonly surfaceVariant: string = '#FAFAFA';
  static readonly outline: string = '#EEEEEE';
  static readonly backgroundTint: string = '#F5F5F5';
  static readonly teaLeafDetail: string = '#8D6E63';
  static readonly favoriteTint: string = '#FFCDD2';
  static readonly textSecondary: string = '#9E9E9E';
  static readonly textPrimary: string = '#000000';
  static readonly iconCircleBg: string = '#EFEBE9';
  static readonly buttonOutline: string = '#E0E0E0';
}

@Entry
@Component
struct TeaBrewingScreen {
  @State steepingTime: string = '02:00';

  @Builder
  CircleIconButton(glyph: string, size: number, fontSize: number,
                   bgColor: string, glyphColor: string, bordered: boolean) {
    Stack() {
      Text(glyph)
        .fontSize(fontSize)
        .fontColor(glyphColor)
    }
    .width(size)
    .height(size)
    .borderRadius(size / 2)
    .backgroundColor(bgColor)
    .border({ width: bordered ? 1 : 0, color: TeaColors.buttonOutline })
  }

  @Builder
  StepRow(step: string, label: string) {
    Row({ space: 12 }) {
      Stack() {
        Text(step)
          .fontSize(11)
          .fontWeight(FontWeight.Bold)
          .fontColor(TeaColors.textPrimary)
      }
      .width(24)
      .height(24)
      .borderRadius(12)
      .backgroundColor(TeaColors.backgroundTint)

      Text(label)
        .fontSize(14)
        .fontColor(TeaColors.textSecondary)
        .layoutWeight(1)

      Text('✓')
        .fontSize(12)
        .fontColor(TeaColors.outline)
    }
    .width('100%')
    .padding({ top: 8, bottom: 8 })
    .alignItems(VerticalAlign.Center)
  }

  build() {
    Column() {
      // ── Header ──────────────────────────────────────────────
      Row() {
        Column() {
          Text('Good Morning,')
            .fontSize(14)
            .fontColor(TeaColors.textSecondary)
          Text('Tea Master')
            .fontSize(22)
            .fontWeight(FontWeight.Bold)
            .fontColor(TeaColors.textPrimary)
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        this.CircleIconButton('⚙', 48, 24, TeaColors.backgroundTint,
          TeaColors.textPrimary, false)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
      .margin({ top: 24, bottom: 32 })

      // ── Tea selection card ──────────────────────────────────
      Row() {
        Stack() {
          Column() {}
            .width(60)
            .height(60)
            .borderRadius(30)
            .backgroundColor(TeaColors.iconCircleBg)

          Column() {}
            .width(30)
            .height(30)
            .borderRadius(15)
            .border({ width: 2, color: TeaColors.primary })

          Column() {}
            .width(2)
            .height(14)
            .borderRadius(1)
            .backgroundColor(TeaColors.primary)
        }
        .width(60)
        .height(60)
        .margin({ right: 16 })

        Column() {
          Text('Earl Grey Reserve')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor(TeaColors.textPrimary)
          Text('Black Tea • 95°C')
            .fontSize(12)
            .fontColor(TeaColors.teaLeafDetail)
            .margin({ top: 2 })
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        Text('♥')
          .fontSize(24)
          .fontColor(TeaColors.favoriteTint)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
      .padding(20)
      .backgroundColor(TeaColors.surfaceVariant)
      .borderRadius(24)
      .border({ width: 1, color: TeaColors.outline })
      .margin({ bottom: 32 })

      // ── Timer ───────────────────────────────────────────────
      Stack() {
        Progress({ value: 66, total: 100, type: ProgressType.Ring })
          .width(220)
          .height(220)
          .color(TeaColors.primary)
          .backgroundColor(TeaColors.backgroundTint)
          .style({ strokeWidth: 12 })
          .rotate({ angle: -120 })

        Column() {
          Text('Steeping')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .letterSpacing(2)
            .fontColor(TeaColors.textSecondary)
          Text(this.steepingTime)
            .fontSize(45)
            .fontWeight(FontWeight.Lighter)
            .fontColor(TeaColors.textPrimary)
            .margin({ top: 4 })
        }
      }
      .width('100%')
      .margin({ bottom: 40 })

      // ── Controls ────────────────────────────────────────────
      Row({ space: 24 }) {
        this.CircleIconButton('↺', 60, 24, '#FFFFFF', TeaColors.textSecondary, true)

        Row({ space: 8 }) {
          Text('▶')
            .fontSize(18)
            .fontColor('#FFFFFF')
          Text('Start')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FFFFFF')
        }
        .width(120)
        .height(60)
        .justifyContent(FlexAlign.Center)
        .backgroundColor(TeaColors.primary)
        .borderRadius(24)

        this.CircleIconButton('+', 60, 26, '#FFFFFF', TeaColors.textSecondary, true)
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .margin({ bottom: 24 })

      Blank()

      // ── Preparation steps ───────────────────────────────────
      Column() {
        Text('PREPARATION')
          .fontSize(11)
          .fontWeight(FontWeight.Bold)
          .letterSpacing(1)
          .fontColor('#BDBDBD')
          .margin({ bottom: 12 })

        this.StepRow('1', 'Boil fresh water to 95°C')
        Divider().color(TeaColors.backgroundTint).strokeWidth(1)
        this.StepRow('2', 'Add 1 tsp of loose leaf per cup')
        Divider().color(TeaColors.backgroundTint).strokeWidth(1)
        this.StepRow('3', 'Pour water and wait for timer')
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
      .margin({ bottom: 24 })
    }
    .width('100%')
    .height('100%')
    .padding({ left: 24, right: 24 })
    .backgroundColor('#FFFFFF')
  }
}