// ─────────────────────────────────────────────────────────────────────────────
// entry/src/main/ets/pages/Index.ets
// 065FlightCheckinen · Travel · Modern Blue   (Kotlin Compose ➜ ArkTS / ArkUI)
// ─────────────────────────────────────────────────────────────────────────────

const APP_NAME: string = '065FlightCheckinen';
const UI_TYPE: string = 'Travel';
const STYLE_THEME: string = 'Modern Blue';
const LANG_CODE: string = 'en';
const BASELINE_SIZE: string = '720x1280';

/* ─────────────────────────────── Design tokens ───────────────────────────── */

class AppColors {
  static readonly primary: string = '#FF1E3A8A';
  static readonly secondary: string = '#FF2563EB';
  static readonly tertiary: string = '#FF60A5FA';
  static readonly background: string = '#FFF5F8FF';
  static readonly surface: string = '#FFFFFFFF';
  static readonly surfaceVariant: string = '#FFE8EEFA';
  static readonly outline: string = '#FFCBD5E1';
  static readonly success: string = '#FF16A34A';
  static readonly warning: string = '#FFF59E0B';
  static readonly error: string = '#FFEF4444';
  static readonly onPrimary: string = '#FFFFFFFF';
  static readonly onSecondary: string = '#FFFFFFFF';
  static readonly onTertiary: string = '#FF0B1220';
  static readonly onBackground: string = '#FF0B1220';
  static readonly onSurface: string = '#FF0B1220';
  static readonly onSurfaceHint: string = '#800B1220';
  static readonly gradTop: string = '#4060A5FA';   // tertiary @ 25%
  static readonly gradBottom: string = '#332563EB'; // secondary @ 20%
}

class AppFont {
  static readonly display: number = 28;
  static readonly headline: number = 20;
  static readonly title: number = 16;
  static readonly body: number = 14;
  static readonly label: number = 12;
}

class AppSpace {
  static readonly xs: number = 6;
  static readonly sm: number = 10;
  static readonly md: number = 14;
  static readonly lg: number = 18;
  static readonly xl: number = 26;
  static readonly xxl: number = 36;
}

class AppRadius {
  static readonly small: number = 8;
  static readonly medium: number = 12;
  static readonly large: number = 18;
}

class AppShadow {
  static readonly level1: ShadowOptions = {
    radius: 4, color: '#1F1E3A8A', offsetX: 0, offsetY: 2
  };
  static readonly level2: ShadowOptions = {
    radius: 8, color: '#291E3A8A', offsetX: 0, offsetY: 4
  };
  static readonly level3: ShadowOptions = {
    radius: 12, color: '#2E1E3A8A', offsetX: 0, offsetY: 6
  };
}

/* ─────────────────────────────── Dialog ─────────────────────────────────── */

@CustomDialog
struct CheckInDialog {
  controller?: CustomDialogController;

  build() {
    Column() {
      Text('Check-in Successful')
        .fontSize(AppFont.title)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .width('100%')

      Text('Boarding pass is ready. Have a nice flight.')
        .fontSize(AppFont.body)
        .fontWeight(FontWeight.Normal)
        .fontColor(AppColors.onSurface)
        .margin({ top: AppSpace.sm })
        .width('100%')

      Row() {
        Button('Done')
          .fontSize(AppFont.label)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSecondary)
          .backgroundColor(AppColors.secondary)
          .height(40)
          .borderRadius(AppRadius.medium)
          .onClick(() => {
            this.controller?.close();
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.End)
      .margin({ top: AppSpace.lg })
    }
    .width('84%')
    .padding(AppSpace.lg)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppRadius.large)
    .shadow(AppShadow.level3)
  }
}

/* ─────────────────────────────── Screen ─────────────────────────────────── */

@Entry
@Component
struct FlightCheckIn {
  @State passengerName: string = '';
  @State bookingCode: string = '';
  @State selectedSeat: number = 0;

  private seatTabs: string[] = ['Economy', 'Premium', 'Business'];

  private dialogController: CustomDialogController = new CustomDialogController({
    builder: CheckInDialog(),
    autoCancel: true,
    alignment: DialogAlignment.Center,
    customStyle: true
  });

  private seatNumber(): string {
    if (this.selectedSeat === 0) {
      return '23C';
    }
    if (this.selectedSeat === 1) {
      return '11A';
    }
    return '2F';
  }

  /* ---------------------------- top app bar ---------------------------- */
  @Builder
  TopBar() {
    Stack() {
      Row() {
        Circle({ width: 22, height: 22 }).fill(AppColors.primary)
        Blank()
        Circle({ width: 22, height: 22 }).fill(AppColors.secondary)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      Text('Flight Check-in')
        .fontSize(AppFont.display)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onSurface)
    }
    .width('100%')
    .height(64)
    .padding({ left: AppSpace.lg, right: AppSpace.lg })
    .backgroundColor(AppColors.surface)
  }

  /* ---------------------------- form card ------------------------------ */
  @Builder
  FormCard() {
    Column() {
      Text('Passenger')
        .fontSize(AppFont.headline)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(AppColors.onSurface)

      Column() {
        TextInput({ placeholder: 'Full name', text: this.passengerName })
          .type(InputType.Normal)
          .height(52)
          .fontSize(AppFont.body)
          .fontColor(AppColors.onSurface)
          .placeholderColor(AppColors.onSurfaceHint)
          .placeholderFont({ size: AppFont.body })
          .caretColor(AppColors.primary)
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(AppRadius.medium)
          .padding({ left: AppSpace.md, right: AppSpace.md })
          .onChange((value: string) => {
            this.passengerName = value;
          })

        Divider().strokeWidth(1).color(AppColors.outline).margin({ top: 1 })
      }
      .width('100%')

      Text('Booking Code')
        .fontSize(AppFont.headline)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(AppColors.onSurface)

      Column() {
        TextInput({ placeholder: 'e.g. XY7ZK2', text: this.bookingCode })
          .type(InputType.Normal)
          .height(52)
          .fontSize(AppFont.body)
          .fontColor(AppColors.onSurface)
          .placeholderColor(AppColors.onSurfaceHint)
          .placeholderFont({ size: AppFont.body })
          .caretColor(AppColors.primary)
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(AppRadius.medium)
          .padding({ left: AppSpace.md, right: AppSpace.md })
          .onChange((value: string) => {
            this.bookingCode = value;
          })

        Divider().strokeWidth(1).color(AppColors.outline).margin({ top: 1 })
      }
      .width('100%')

      Text('Seat Class')
        .fontSize(AppFont.headline)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(AppColors.onSurface)

      Row() {
        ForEach(this.seatTabs, (label: string, index: number) => {
          Row() {
            if (this.selectedSeat === index) {
              Text('✓')
                .fontSize(AppFont.label + 2)
                .fontColor(AppColors.onPrimary)
                .margin({ right: AppSpace.xs })
            }
            Text(label)
              .fontSize(AppFont.label)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.selectedSeat === index ? AppColors.onPrimary : AppColors.onSurface)
          }
          .justifyContent(FlexAlign.Center)
          .layoutWeight(1)
          .height(44)
          .backgroundColor(this.selectedSeat === index ? AppColors.primary : AppColors.surfaceVariant)
          .onClick(() => {
            this.selectedSeat = index;
          })
        }, (label: string) => label)
      }
      .width('100%')
      .height(44)
      .borderRadius(22)
      .clip(true)
      .margin({ top: AppSpace.xs })
    }
    .width('100%')
    .padding(AppSpace.lg)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppRadius.large)
    .shadow(AppShadow.level2)
    .alignItems(HorizontalAlign.Start)
  }

  /* ---------------------------- flight card ---------------------------- */
  @Builder
  FlightCard() {
    Column() {
      Row() {
        Column() {
          Text('Flight')
            .fontSize(AppFont.title)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
          Text('BL 213 • HND → CTS')
            .fontSize(AppFont.body)
            .fontWeight(FontWeight.Normal)
            .fontColor(AppColors.onSurface)
            .margin({ top: AppSpace.xs })
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        Circle({ width: 36, height: 36 }).fill(AppColors.secondary)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      Row() {
        Column() {
          Text('Boarding')
            .fontSize(AppFont.label)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
          Text('12:35')
            .fontSize(AppFont.title)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.primary)
            .margin({ top: AppSpace.xs })
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        Column() {
          Text('Gate')
            .fontSize(AppFont.label)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
          Text('A12')
            .fontSize(AppFont.title)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.primary)
            .margin({ top: AppSpace.xs })
        }
        .alignItems(HorizontalAlign.Center)

        Blank()

        Column() {
          Text('Seat')
            .fontSize(AppFont.label)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
          Text(this.seatNumber())
            .fontSize(AppFont.title)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.primary)
            .margin({ top: AppSpace.xs })
        }
        .alignItems(HorizontalAlign.End)
      }
      .width('100%')
      .margin({ top: AppSpace.lg })
      .alignItems(VerticalAlign.Center)

      Button('Confirm Check-in')
        .fontSize(AppFont.title)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .backgroundColor(AppColors.primary)
        .width('100%')
        .height(52)
        .borderRadius(AppRadius.large)
        .margin({ top: AppSpace.lg })
        .onClick(() => {
          this.dialogController.open();
        })
    }
    .width('100%')
    .padding(AppSpace.lg)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppRadius.large)
    .shadow(AppShadow.level2)
    .alignItems(HorizontalAlign.Start)
  }

  /* ------------------------------- build ------------------------------- */
  build() {
    Column() {
      this.TopBar()

      Column() {
        this.FormCard()
        this.FlightCard()
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: AppSpace.lg, right: AppSpace.lg, top: AppSpace.md, bottom: AppSpace.md })
      .justifyContent(FlexAlign.Start)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
    .linearGradient({
      angle: 180,
      colors: [
        [AppColors.gradTop, 0.0],
        [AppColors.background, 0.5],
        [AppColors.gradBottom, 1.0]
      ]
    })
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}