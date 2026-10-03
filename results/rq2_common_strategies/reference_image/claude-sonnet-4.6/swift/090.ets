// entry/src/main/ets/pages/LumenApp.ets
// ArkTS port of LumenAppScreen (SwiftUI) — HarmonyOS / ArkUI (API 11+)

@Entry
@Component
struct LumenApp {
  // ── State (对应 SwiftUI 的 @State) ──────────────────────────────
  @State selectedIso: string = '400';
  @State apertureValue: number = 2.8;
  @State selectedSpeedIndex: number = 4;

  // ── Data / constants ─────────────────────────────────────────
  private readonly isoValues: string[] = ['100', '200', '400', '800', '1600', '3200'];
  private readonly shutterSpeeds: string[] = ['1/1000', '1/500', '1/250', '1/125', '1/60', '1/30', '1/15', '1/8'];

  private readonly apertureMin: number = 1.4;
  private readonly apertureMax: number = 16.0;
  private readonly apertureStep: number = (16.0 - 1.4) / 20.0; // 对应 Compose 的 steps 换算

  private readonly pagePadding: number = 24;
  private readonly groupSpacing: number = 32;
  private readonly sectionLabelSpacing: number = 12;

  // 颜色（对应 Color(hex:) 扩展）
  private readonly cardBg: string = '#FFF8F8F8';
  private readonly cardBorder: string = '#FFEEEEEE';
  private readonly lineGray: string = '#FFE0E0E0';
  private readonly grayText: string = '#FF808080';
  private readonly iconGray: string = '#FF999999';
  private readonly selectedSpeedBg: string = '#FFF0F0F0';

  // ── 计算辅助（build() 内不允许声明局部变量） ────────────────────
  private prevSpeed(): string {
    return this.selectedSpeedIndex > 0 ? this.shutterSpeeds[this.selectedSpeedIndex - 1] : '-';
  }

  private currSpeed(): string {
    return this.shutterSpeeds[this.selectedSpeedIndex];
  }

  private nextSpeed(): string {
    return this.selectedSpeedIndex < this.shutterSpeeds.length - 1
      ? this.shutterSpeeds[this.selectedSpeedIndex + 1]
      : '-';
  }

  // ── Header ───────────────────────────────────────────────────
  @Builder
  headerSection() {
    Row() {
      Column() {
        Text('LUMEN LOG')
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .letterSpacing(2)
          .fontColor(this.grayText)

        Text('Roll #034')
          .fontSize(24)
          .fontWeight(FontWeight.Bolder) // .heavy
          .fontColor(Color.Black)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Row({ space: 0 }) {
        // 菜单图标（用三条横线绘制，可替换为 Image($r('app.media.ic_menu'))）
        Column({ space: 4 }) {
          Row().width(18).height(2).backgroundColor(Color.Black)
          Row().width(18).height(2).backgroundColor(Color.Black)
          Row().width(18).height(2).backgroundColor(Color.Black)
        }
        .width(44)
        .height(44)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .onClick(() => {
          // no-op
        })

        // 设置图标（可替换为 Image($r('app.media.ic_settings'))）
        Text('⚙')
          .fontSize(22)
          .fontColor(Color.Black)
          .width(44)
          .height(44)
          .textAlign(TextAlign.Center)
          .onClick(() => {
            // no-op
          })
      }
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
    .margin({ bottom: 16 })
  }

  // ── 当前曝光参数卡片 ──────────────────────────────────────────
  @Builder
  currentSettingsCard() {
    Row() {
      // Aperture —— 主视觉
      Column() {
        Text('f/' + this.apertureValue.toFixed(1))
          .fontSize(56)
          .fontWeight(FontWeight.Lighter)
          .letterSpacing(-2)
          .fontColor(Color.Black)

        Text('APERTURE')
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.grayText)
      }
      .layoutWeight(3) // 对应 weight(1.5f)
      .alignItems(HorizontalAlign.Start)
      .justifyContent(FlexAlign.Center)
      .padding({ right: 12 })

      // 分隔线
      Divider()
        .vertical(true)
        .height(80)
        .strokeWidth(1)
        .color(this.lineGray)

      // ISO / SHUTTER —— 次要信息
      Column({ space: 16 }) {
        Column() {
          Text(this.selectedIso)
            .fontSize(20)
            .fontWeight(FontWeight.Medium)
            .fontColor(Color.Black)
          Text('ISO')
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.grayText)
        }
        .alignItems(HorizontalAlign.Start)

        Column() {
          Text(this.currSpeed())
            .fontSize(20)
            .fontWeight(FontWeight.Medium)
            .fontColor(Color.Black)
          Text('SHUTTER')
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.grayText)
        }
        .alignItems(HorizontalAlign.Start)
      }
      .layoutWeight(2) // 对应 weight(1f)
      .alignItems(HorizontalAlign.Start)
      .justifyContent(FlexAlign.Center)
      .padding({ left: 24 })
    }
    .width('100%')
    .height(160)
    .padding({ left: 24, right: 24 })
    .backgroundColor(this.cardBg)
    .borderRadius(16)
    .border({ width: 1, color: this.cardBorder })
  }

  // ── ISO 选择器 ───────────────────────────────────────────────
  @Builder
  isoSelector() {
    Column() {
      Text('Film Stock ISO')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
        .margin({ bottom: this.sectionLabelSpacing })

      Scroll() {
        Row({ space: 12 }) {
          ForEach(this.isoValues, (iso: string) => {
            Text(iso)
              .fontSize(13)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.selectedIso === iso ? Color.White : Color.Black)
              .textAlign(TextAlign.Center)
              .width(60)
              .height(36)
              .borderRadius(18) // RoundedCornerShape(50) = 胶囊
              .backgroundColor(this.selectedIso === iso ? Color.Black : Color.Transparent)
              .border({
                width: 1,
                color: this.selectedIso === iso ? Color.Black : this.lineGray
              })
              .onClick(() => {
                this.selectedIso = iso;
              })
          }, (iso: string) => iso)
        }
      }
      .scrollable(ScrollDirection.Horizontal)
      .scrollBar(BarState.Off)
      .width('100%')
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }

  // ── 光圈控制 ─────────────────────────────────────────────────
  @Builder
  apertureControl() {
    Column() {
      Row() {
        Text('Aperture Control')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.Black)

        Blank()

        Text('⚙')
          .fontSize(16)
          .fontColor(this.iconGray)
      }
      .width('100%')
      .margin({ bottom: 8 })

      Slider({
        value: this.apertureValue,
        min: this.apertureMin,
        max: this.apertureMax,
        step: this.apertureStep,
        style: SliderStyle.InSet
      })
        .width('100%')
        .trackThickness(2)
        .trackColor(this.lineGray)
        .selectedColor(Color.Black)
        .blockColor(Color.Black)
        .blockSize({ width: 28, height: 28 })
        .onChange((value: number, mode: SliderChangeMode) => {
          this.apertureValue = value;
        })

      Row() {
        Text('f/1.4')
          .fontSize(12)
          .fontColor(this.grayText)
        Blank()
        Text('f/16')
          .fontSize(12)
          .fontColor(this.grayText)
      }
      .width('100%')
      .margin({ top: 4 })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }

  // ── 快门速度选择器 ───────────────────────────────────────────
  @Builder
  shutterSpeedControl() {
    Column() {
      Text('Shutter Speed')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
        .margin({ bottom: this.sectionLabelSpacing })

      Row() {
        // 前一项
        Text(this.prevSpeed())
          .fontSize(16)
          .fontWeight(FontWeight.Normal)
          .fontColor(this.lineGray)
          .textAlign(TextAlign.Center)
          .width(100)
          .height(50)
          .borderRadius(12)
          .onClick(() => {
            if (this.selectedSpeedIndex > 0 && this.prevSpeed() !== '-') {
              this.selectedSpeedIndex--;
            }
          })

        // 当前项（选中态，不可点击）
        Text(this.currSpeed())
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
          .textAlign(TextAlign.Center)
          .width(100)
          .height(50)
          .borderRadius(12)
          .backgroundColor(this.selectedSpeedBg)

        // 后一项
        Text(this.nextSpeed())
          .fontSize(16)
          .fontWeight(FontWeight.Normal)
          .fontColor(this.lineGray)
          .textAlign(TextAlign.Center)
          .width(100)
          .height(50)
          .borderRadius(12)
          .onClick(() => {
            if (this.selectedSpeedIndex < this.shutterSpeeds.length - 1 && this.nextSpeed() !== '-') {
              this.selectedSpeedIndex++;
            }
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }

  // ── 底部按钮 ─────────────────────────────────────────────────
  @Builder
  logShotButton() {
    Row({ space: 12 }) {
      Stack() {
        Circle().width(24).height(24).fill(Color.White)
        Text('+')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.Black)
      }
      .width(24)
      .height(24)

      Text('LOG EXPOSURE')
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .letterSpacing(1)
        .fontColor(Color.White)
    }
    .width('100%')
    .height(56)
    .justifyContent(FlexAlign.Center)
    .backgroundColor(Color.Black)
    .borderRadius(12)
    .onClick(() => {
      // no-op：对应 Swift 的 Button(action: {})
    })
  }

  // ── 根布局（对应 LumenAppScreen） ────────────────────────────
  build() {
    Column() {
      this.headerSection()

      this.currentSettingsCard()

      Blank().layoutWeight(1) // 对应 Spacer()

      Column({ space: this.groupSpacing }) {
        this.isoSelector()
        this.apertureControl()
        this.shutterSpeedControl()
      }
      .width('100%')

      Blank().layoutWeight(1) // 对应 Spacer()

      this.logShotButton()
    }
    .width('100%')
    .height('100%')
    .padding(this.pagePadding)
    .backgroundColor(Color.White)
    .alignItems(HorizontalAlign.Start)
  }
}