const NAME: string = '065FlightCheckinen';
const UI_TYPE: string = 'Travel';
const STYLE_THEME: string = 'Modern Blue';
const LANG: string = 'en';
const BASELINE_SIZE: string = '720x1280';

class AppColors {
  static readonly primary: string = '#1E3A8A';
  static readonly secondary: string = '#2563EB';
  static readonly tertiary: string = '#60A5FA';
  static readonly background: string = '#F5F8FF';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#E8EEFA';
  static readonly outline: string = '#CBD5E1';
  static readonly success: string = '#16A34A';
  static readonly warning: string = '#F59E0B';
  static readonly error: string = '#EF4444';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#FFFFFF';
  static readonly onTertiary: string = '#0B1220';
  static readonly onBackground: string = '#0B1220';
  static readonly onSurface: string = '#0B1220';
}

class AppSpacing {
  static readonly xs: number = 6;
  static readonly sm: number = 10;
  static readonly md: number = 14;
  static readonly lg: number = 18;
  static readonly xl: number = 26;
  static readonly xxl: number = 36;
}

@Entry
@Component
struct MainActivity {
  @State name: string = '';
  @State code: string = '';
  @State selectedSeat: number = 0;
  @State showDialog: boolean = false;
  private seatTabs: string[] = ['Economy', 'Premium', 'Business'];

  seatLabel(): string {
    if (this.selectedSeat === 0) {
      return '23C';
    }
    if (this.selectedSeat === 1) {
      return '11A';
    }
    return '2F';
  }

  @Builder
  TopBar(): void {
    Row() {
      Circle().width(22).height(22).fill(AppColors.primary);
      Blank();
      Text('Flight Check-in')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onSurface);
      Blank();
      Circle().width(22).height(22).fill(AppColors.secondary);
    }
    .width('100%')
    .height(56)
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.background);
  }

  @Builder
  InputField(value: string, placeholder: string, field: string): void {
    TextInput({ text: value, placeholder: placeholder })
      .fontSize(14)
      .fontColor(AppColors.onSurface)
      .placeholderColor('#800B1220')
      .backgroundColor(AppColors.surfaceVariant)
      .border({ width: 1, color: AppColors.outline })
      .borderRadius(12)
      .width('100%')
      .height(48)
      .onChange((next: string) => {
        if (field === 'name') {
          this.name = next;
        } else {
          this.code = next;
        }
      });
  }

  @Builder
  PassengerCard(): void {
    Column({ space: AppSpacing.md }) {
      Text('Passenger')
        .fontSize(20)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(AppColors.onSurface);
      this.InputField(this.name, 'Full name', 'name');
      Text('Booking Code')
        .fontSize(20)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(AppColors.onSurface);
      this.InputField(this.code, 'e.g. XY7ZK2', 'code');
      Text('Seat Class')
        .fontSize(20)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(AppColors.onSurface);
      Row() {
        ForEach(this.seatTabs, (label: string, index: number) => {
          Button(label)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.selectedSeat === index ? AppColors.onPrimary : AppColors.onSurface)
            .backgroundColor(this.selectedSeat === index ? AppColors.primary : AppColors.surfaceVariant)
            .layoutWeight(1)
            .height(38)
            .onClick(() => {
              this.selectedSeat = index;
            });
        }, (label: string) => label)
      }
      .width('100%')
      .borderRadius(12);
    }
    .width('100%')
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.surface)
    .borderRadius(18)
    .shadow({ radius: 8, color: '#29000000', offsetY: 4 })
    .alignItems(HorizontalAlign.Start);
  }

  @Builder
  FlightCard(): void {
    Column({ space: AppSpacing.md }) {
      Row() {
        Column({ space: AppSpacing.xs }) {
          Text('Flight')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface);
          Text('BL 213 • HND → CTS')
            .fontSize(14)
            .fontColor(AppColors.onSurface);
        }
        .alignItems(HorizontalAlign.Start);
        Blank();
        Circle().width(36).height(36).fill(AppColors.secondary);
      }
      .width('100%')
      .alignItems(VerticalAlign.Center);
      Row() {
        this.InfoBlock('Boarding', '12:35');
        Blank();
        this.InfoBlock('Gate', 'A12');
        Blank();
        this.InfoBlock('Seat', this.seatLabel());
      }
      .width('100%')
      .alignItems(VerticalAlign.Center);
      Button('Confirm Check-in')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .backgroundColor(AppColors.primary)
        .borderRadius(18)
        .width('100%')
        .height(52)
        .onClick(() => {
          this.showDialog = true;
        });
    }
    .width('100%')
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.surface)
    .borderRadius(18)
    .shadow({ radius: 8, color: '#29000000', offsetY: 4 })
    .alignItems(HorizontalAlign.Start);
  }

  @Builder
  InfoBlock(label: string, value: string): void {
    Column() {
      Text(label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface);
      Text(value)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.primary);
    }
    .alignItems(HorizontalAlign.Start);
  }

  @Builder
  Dialog(): void {
    if (this.showDialog) {
      Stack() {
        Rect().width('100%').height('100%').fill('#66000000');
        Column({ space: AppSpacing.md }) {
          Text('Check-in Successful')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface);
          Text('Boarding pass is ready. Have a nice flight.')
            .fontSize(14)
            .fontColor(AppColors.onSurface);
          Button('Done')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSecondary)
            .backgroundColor(AppColors.secondary)
            .borderRadius(12)
            .onClick(() => {
              this.showDialog = false;
            });
        }
        .width(300)
        .padding(AppSpacing.lg)
        .backgroundColor(AppColors.surface)
        .borderRadius(18)
        .alignItems(HorizontalAlign.Start);
      }
      .width('100%')
      .height('100%')
      .alignContent(Alignment.Center);
    }
  }

  build() {
    Stack() {
      Column() {
        this.TopBar();
        Column({ space: AppSpacing.lg }) {
          this.PassengerCard();
          this.FlightCard();
        }
        .width('100%')
        .layoutWeight(1)
        .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md, bottom: AppSpacing.md })
        .backgroundColor(AppColors.background);
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppColors.background);
      this.Dialog();
    }
    .width('100%')
    .height('100%');
  }
}
