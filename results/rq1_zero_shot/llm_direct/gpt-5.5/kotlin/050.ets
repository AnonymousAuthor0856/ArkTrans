const NAME: string = '065FlightCheckinen';
const UI_TYPE: string = 'Travel';
const STYLE_THEME: string = 'Modern Blue';
const LANG: string = 'en';
const BASELINE_SIZE: string = '720x1280';

class AppColors {
  static readonly primary: string = '#FF1E3A8A';
  static readonly secondary: string = '#FF2563EB';
  static readonly tertiary: string = '#FF60A5FA';
  static readonly tertiary25: string = '#4060A5FA';
  static readonly secondary20: string = '#332563EB';
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
  static readonly onSurface50: string = '#800B1220';
}

class AppTypographyTokens {
  static readonly displaySize: number = 28;
  static readonly headlineSize: number = 20;
  static readonly titleSize: number = 16;
  static readonly bodySize: number = 14;
  static readonly labelSize: number = 12;
}

class AppShapes {
  static readonly small: number = 8;
  static readonly medium: number = 12;
  static readonly large: number = 18;
}

class AppSpacing {
  static readonly xs: number = 6;
  static readonly sm: number = 10;
  static readonly md: number = 14;
  static readonly lg: number = 18;
  static readonly xl: number = 26;
  static readonly xxl: number = 36;
}

class ShadowSpec {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;

  constructor(elevation: number, radius: number, dy: number, opacity: number) {
    this.elevation = elevation;
    this.radius = radius;
    this.dy = dy;
    this.opacity = opacity;
  }
}

class AppElevationMapping {
  static readonly level1: ShadowSpec = new ShadowSpec(2, 4, 2, 0.12);
  static readonly level2: ShadowSpec = new ShadowSpec(6, 8, 4, 0.16);
  static readonly level3: ShadowSpec = new ShadowSpec(10, 12, 6, 0.18);
}

@CustomDialog
struct SuccessDialog {
  controller?: CustomDialogController;

  build() {
    Column({ space: AppSpacing.md }) {
      Text('Check-in Successful')
        .fontSize(AppTypographyTokens.titleSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .width('100%');

      Text('Boarding pass is ready. Have a nice flight.')
        .fontSize(AppTypographyTokens.bodySize)
        .fontWeight(FontWeight.Regular)
        .fontColor(AppColors.onSurface)
        .width('100%');

      Row() {
        Blank();

        Button({ type: ButtonType.Normal, stateEffect: true }) {
          Text('Done')
            .fontSize(AppTypographyTokens.labelSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSecondary);
        }
        .height(42)
        .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
        .backgroundColor(AppColors.secondary)
        .borderRadius(AppShapes.medium)
        .onClick(() => {
          this.controller?.close();
        });
      }
      .width('100%');
    }
    .width('82%')
    .padding(AppSpacing.xl)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.large);
  }
}

@Entry
@Component
struct MainPage {
  @State private name: string = '';
  @State private code: string = '';
  @State private selectedSeat: number = 0;

  private seatTabs: string[] = ['Economy', 'Premium', 'Business'];

  private successDialogController: CustomDialogController = new CustomDialogController({
    builder: SuccessDialog(),
    autoCancel: true,
    customStyle: true,
    alignment: DialogAlignment.Center
  });

  private currentSeat(): string {
    if (this.selectedSeat === 0) {
      return '23C';
    }
    if (this.selectedSeat === 1) {
      return '11A';
    }
    return '2F';
  }

  @Builder
  private TopBar() {
    Stack({ alignContent: Alignment.Center }) {
      Row() {
        Stack()
          .width(22)
          .height(22)
          .borderRadius(11)
          .backgroundColor(AppColors.primary);

        Blank();

        Stack()
          .width(22)
          .height(22)
          .borderRadius(11)
          .backgroundColor(AppColors.secondary);
      }
      .width('100%')
      .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
      .alignItems(VerticalAlign.Center);

      Text('Flight Check-in')
        .fontSize(AppTypographyTokens.displaySize)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onSurface);
    }
    .width('100%')
    .height(84)
    .backgroundColor(AppColors.surface);
  }

  @Builder
  private SectionTitle(label: string) {
    Text(label)
      .fontSize(AppTypographyTokens.headlineSize)
      .fontWeight(FontWeight.Medium)
      .fontColor(AppColors.onSurface)
      .width('100%');
  }

  @Builder
  private AppTextField(value: string, placeholder: string, onChange: (value: string) => void) {
    TextInput({ text: value, placeholder: placeholder })
      .width('100%')
      .height(52)
      .fontSize(AppTypographyTokens.bodySize)
      .fontColor(AppColors.onSurface)
      .placeholderColor(AppColors.onSurface50)
      .caretColor(AppColors.primary)
      .backgroundColor(AppColors.surfaceVariant)
      .borderRadius(AppShapes.medium)
      .border({ width: 1, color: AppColors.outline })
      .padding({ left: AppSpacing.md, right: AppSpacing.md })
      .onChange(onChange);
  }

  @Builder
  private PassengerCard() {
    Column({ space: AppSpacing.md }) {
      this.SectionTitle('Passenger');

      this.AppTextField(this.name, 'Full name', (value: string) => {
        this.name = value;
      });

      this.SectionTitle('Booking Code');

      this.AppTextField(this.code, 'e.g. XY7ZK2', (value: string) => {
        this.code = value;
      });

      this.SectionTitle('Seat Class');

      Row() {
        ForEach(this.seatTabs, (label: string, index: number) => {
          Button({ type: ButtonType.Normal, stateEffect: true }) {
            Text(label)
              .fontSize(AppTypographyTokens.labelSize)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.selectedSeat === index ? AppColors.onPrimary : AppColors.onSurface);
          }
          .layoutWeight(1)
          .height(42)
          .backgroundColor(this.selectedSeat === index ? AppColors.primary : AppColors.surfaceVariant)
          .border({
            width: 1,
            color: this.selectedSeat === index ? AppColors.primary : AppColors.outline
          })
          .borderRadius({
            topLeft: index === 0 ? AppShapes.medium : 0,
            bottomLeft: index === 0 ? AppShapes.medium : 0,
            topRight: index === this.seatTabs.length - 1 ? AppShapes.medium : 0,
            bottomRight: index === this.seatTabs.length - 1 ? AppShapes.medium : 0
          })
          .onClick(() => {
            this.selectedSeat = index;
          });
        }, (label: string) => label);
      }
      .width('100%');
    }
    .width('100%')
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.large)
    .shadow({
      radius: AppElevationMapping.level2.radius,
      color: '#29000000',
      offsetX: 0,
      offsetY: AppElevationMapping.level2.dy
    });
  }

  @Builder
  private FlightCard() {
    Column({ space: AppSpacing.md }) {
      Row() {
        Column({ space: AppSpacing.xs }) {
          Text('Flight')
            .fontSize(AppTypographyTokens.titleSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface);

          Text('BL 213 • HND → CTS')
            .fontSize(AppTypographyTokens.bodySize)
            .fontWeight(FontWeight.Regular)
            .fontColor(AppColors.onSurface);
        }
        .alignItems(HorizontalAlign.Start);

        Blank();

        Stack()
          .width(36)
          .height(36)
          .borderRadius(18)
          .backgroundColor(AppColors.secondary);
      }
      .width('100%')
      .alignItems(VerticalAlign.Center);

      Row() {
        Column() {
          Text('Boarding')
            .fontSize(AppTypographyTokens.labelSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface);

          Text('12:35')
            .fontSize(AppTypographyTokens.titleSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.primary);
        }
        .alignItems(HorizontalAlign.Start);

        Column() {
          Text('Gate')
            .fontSize(AppTypographyTokens.labelSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface);

          Text('A12')
            .fontSize(AppTypographyTokens.titleSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.primary);
        }
        .alignItems(HorizontalAlign.Start);

        Column() {
          Text('Seat')
            .fontSize(AppTypographyTokens.labelSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface);

          Text(this.currentSeat())
            .fontSize(AppTypographyTokens.titleSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.primary);
        }
        .alignItems(HorizontalAlign.Start);
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center);

      Button({ type: ButtonType.Normal, stateEffect: true }) {
        Text('Confirm Check-in')
          .fontSize(AppTypographyTokens.titleSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onPrimary);
      }
      .width('100%')
      .height(52)
      .backgroundColor(AppColors.primary)
      .borderRadius(AppShapes.large)
      .onClick(() => {
        this.successDialogController.open();
      });
    }
    .width('100%')
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.large)
    .shadow({
      radius: AppElevationMapping.level2.radius,
      color: '#29000000',
      offsetX: 0,
      offsetY: AppElevationMapping.level2.dy
    });
  }

  build() {
    Column() {
      this.TopBar();

      Column({ space: AppSpacing.lg }) {
        this.PassengerCard();
        this.FlightCard();
        Blank();
      }
      .width('100%')
      .layoutWeight(1)
      .padding({
        left: AppSpacing.lg,
        right: AppSpacing.lg,
        top: AppSpacing.md,
        bottom: AppSpacing.md
      })
      .linearGradient({
        angle: 180,
        colors: [
          [AppColors.tertiary25, 0.0],
          [AppColors.background, 0.5],
          [AppColors.secondary20, 1.0]
        ]
      });
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background);
  }
}