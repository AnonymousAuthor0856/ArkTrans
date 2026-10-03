/**
 * 032_WalletDashFinance_en
 * UI_TYPE      : Finance/Wallet
 * STYLE_THEME  : Monochrome Comfortable
 * LANG         : en
 * BASELINE_SIZE: 720x1280  (360x640 vp @ 2x)
 */

const NAME: string = '032_WalletDashFinance_en';
const UI_TYPE: string = 'Finance/Wallet';
const STYLE_THEME: string = 'Monochrome Comfortable';
const LANG: string = 'en';
const BASELINE_SIZE: string = '720x1280';

/* ------------------------------------------------------------------ *
 * Design tokens
 * ------------------------------------------------------------------ */
class AppColors {
  static readonly primary: string = '#020617';
  static readonly secondary: string = '#4ADE80';
  static readonly tertiary: string = '#64748B';
  static readonly background: string = '#F8FAFC';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#F1F5F9';
  static readonly outline: string = '#E2E8F0';
  static readonly success: string = '#22C55E';
  static readonly warning: string = '#F59E0B';
  static readonly error: string = '#EF4444';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#020617';
  static readonly onTertiary: string = '#FFFFFF';
  static readonly onBackground: string = '#020617';
  static readonly onSurface: string = '#020617';
  // onPrimary.copy(alpha = 0.7f)
  static readonly onPrimary70: string = '#B3FFFFFF';
}

class AppFont {
  static readonly displaySize: number = 48;
  static readonly displayLine: number = 56;
  static readonly headlineSize: number = 28;
  static readonly headlineLine: number = 36;
  static readonly titleSize: number = 20;
  static readonly titleLine: number = 28;
  static readonly bodySize: number = 16;
  static readonly bodyLine: number = 24;
  static readonly labelSize: number = 12;
  static readonly labelLine: number = 16;
}

class AppWeight {
  static readonly regular: number = 400;
  static readonly medium: number = 500;
  static readonly semibold: number = 600;
  static readonly bold: number = 700;
}

class AppRadius {
  static readonly small: number = 8;
  static readonly medium: number = 16;
  static readonly large: number = 24;
  static readonly pill: number = 999;
}

class AppSpace {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 16;
  static readonly lg: number = 24;
  static readonly xl: number = 32;
  static readonly xxl: number = 48;
}

class AppShadow {
  // ShadowSpec(elevation, radius, dy, opacity)
  static readonly level1: ShadowOptions = { radius: 3, color: '#0D000000', offsetX: 0, offsetY: 1 };
  static readonly level2: ShadowOptions = { radius: 8, color: '#14000000', offsetX: 0, offsetY: 2 };
  static readonly level3: ShadowOptions = { radius: 12, color: '#1A000000', offsetX: 0, offsetY: 4 };
}

/* ------------------------------------------------------------------ *
 * Data model
 * ------------------------------------------------------------------ */
interface Transaction {
  id: number;
  name: string;
  detail: string;
  amount: string;
  isCredit: boolean;
}

/* ------------------------------------------------------------------ *
 * Screen
 * ------------------------------------------------------------------ */
@Entry
@Component
struct WalletDashScreen {
  @State selectedNav: string = 'Home';

  private transactions: Transaction[] = [
    { id: 1, name: 'Spotify', detail: 'Subscription', amount: '-$9.99', isCredit: false },
    { id: 2, name: 'Income', detail: 'Monthly Salary', amount: '+$2,500.00', isCredit: true },
    { id: 3, name: 'Starbucks', detail: 'Coffee', amount: '-$5.75', isCredit: false },
    { id: 4, name: 'Amazon', detail: 'Shopping', amount: '-$124.50', isCredit: false },
    { id: 5, name: 'Refund', detail: 'Amazon Return', amount: '+$32.00', isCredit: true }
  ];

  private controlActions: string[] = ['Send', 'Receive', 'Add', 'More'];
  private navItems: string[] = ['Home', 'Cards', 'Activity', 'Profile'];

  /* -------------------------- top bar -------------------------- */
  @Builder
  topBar() {
    Stack() {
      Row() {
        Box()
          .width(28)
          .height(28)
          .borderRadius(AppRadius.pill)
          .backgroundColor(AppColors.surfaceVariant)
        Box()
          .width(28)
          .height(28)
          .borderRadius(AppRadius.pill)
          .backgroundColor(AppColors.surfaceVariant)
      }
      .width('100%')
      .padding({ left: AppSpace.md, right: AppSpace.md })
      .justifyContent(FlexAlign.SpaceBetween)

      Text('My Wallet')
        .fontSize(AppFont.titleSize)
        .fontWeight(AppWeight.medium)
        .fontColor(AppColors.onSurface)
    }
    .width('100%')
    .height(56)
    .alignContent(Alignment.Center)
  }

  /* ------------------------ balance card ----------------------- */
  @Builder
  balanceCard() {
    Column({ space: AppSpace.sm }) {
      Text('Total Balance')
        .fontSize(AppFont.bodySize)
        .fontWeight(AppWeight.regular)
        .lineHeight(AppFont.bodyLine)
        .fontColor(AppColors.onPrimary70)

      Text('$ 1,145.14')
        .fontSize(AppFont.displaySize)
        .fontWeight(AppWeight.bold)
        .lineHeight(AppFont.displayLine)
        .fontColor(AppColors.onPrimary)

      Row({ space: AppSpace.sm }) {
        Box()
          .width(10)
          .height(10)
          .borderRadius(AppRadius.pill)
          .backgroundColor(AppColors.secondary)

        Text('+$234.10 today')
          .fontSize(AppFont.bodySize)
          .fontWeight(AppWeight.regular)
          .fontColor(AppColors.secondary)
      }
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding(AppSpace.lg)
    .borderRadius(AppRadius.large)
    .backgroundColor(AppColors.primary)
    .shadow(AppShadow.level2)
  }

  /* ----------------------- control actions --------------------- */
  @Builder
  controlRow() {
    Row() {
      ForEach(this.controlActions, (label: string) => {
        Column({ space: AppSpace.sm }) {
          Column() {
            Box()
              .width(24)
              .height(24)
              .borderRadius(AppRadius.small)
              .backgroundColor(AppColors.primary)
          }
          .width(64)
          .height(64)
          .borderRadius(AppRadius.pill)
          .backgroundColor(AppColors.surface)
          .justifyContent(FlexAlign.Center)
          .shadow(AppShadow.level1)

          Text(label)
            .fontSize(AppFont.labelSize)
            .fontWeight(AppWeight.medium)
            .fontColor(AppColors.onSurface)
        }
        .alignItems(HorizontalAlign.Center)
      }, (label: string) => label)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceAround)
    .alignItems(VerticalAlign.Center)
  }

  /* ---------------------- activity header ---------------------- */
  @Builder
  activityHeader() {
    Row() {
      Text('Recent Activity')
        .fontSize(AppFont.titleSize)
        .fontWeight(AppWeight.medium)
        .fontColor(AppColors.onSurface)

      Blank()

      Text('View All')
        .fontSize(AppFont.labelSize)
        .fontWeight(AppWeight.medium)
        .fontColor(AppColors.tertiary)
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }

  /* ---------------------- transaction row ---------------------- */
  @Builder
  transactionRow(tx: Transaction) {
    Row({ space: AppSpace.md }) {
      Box()
        .width(48)
        .height(48)
        .borderRadius(AppRadius.medium)
        .backgroundColor(AppColors.surfaceVariant)

      Column({ space: 2 }) {
        Text(tx.name)
          .fontSize(AppFont.bodySize)
          .fontWeight(AppWeight.semibold)
          .fontColor(AppColors.onSurface)

        Text(tx.detail)
          .fontSize(AppFont.labelSize)
          .fontWeight(AppWeight.medium)
          .fontColor(AppColors.tertiary)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Text(tx.amount)
        .fontSize(AppFont.bodySize)
        .fontWeight(AppWeight.semibold)
        .textAlign(TextAlign.End)
        .fontColor(tx.isCredit ? AppColors.success : AppColors.onSurface)
    }
    .width('100%')
    .padding(AppSpace.md)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppRadius.medium)
    .border({ width: 1, color: AppColors.outline })
  }

  /* ------------------------ bottom nav ------------------------- */
  @Builder
  bottomNav() {
    Row() {
      ForEach(this.navItems, (label: string) => {
        Column({ space: AppSpace.xs }) {
          Stack() {
            if (this.selectedNav === label) {
              Row()
                .width(64)
                .height(32)
                .borderRadius(AppRadius.medium)
                .backgroundColor(AppColors.surfaceVariant)
            }
            Box()
              .width(24)
              .height(24)
              .borderRadius(AppRadius.pill)
              .backgroundColor(this.selectedNav === label ? AppColors.primary : AppColors.outline)
          }
          .height(32)
          .alignContent(Alignment.Center)

          Text(label)
            .fontSize(AppFont.labelSize)
            .fontWeight(AppWeight.medium)
            .fontColor(this.selectedNav === label ? AppColors.primary : AppColors.tertiary)
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center)
        .onClick(() => {
          this.selectedNav = label;
        })
      }, (label: string) => label)
    }
    .width('100%')
    .padding({ left: AppSpace.sm, right: AppSpace.sm, top: AppSpace.sm, bottom: AppSpace.sm })
    .backgroundColor(AppColors.surface)
    .shadow(AppShadow.level3)
  }

  /* --------------------------- build --------------------------- */
  build() {
    Column() {
      this.topBar()

      Scroll() {
        Column({ space: AppSpace.lg }) {
          this.balanceCard()

          this.controlRow()

          Column({ space: AppSpace.md }) {
            this.activityHeader()

            ForEach(this.transactions, (tx: Transaction) => {
              this.transactionRow(tx)
            }, (tx: Transaction) => tx.id.toString())
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)
        }
        .width('100%')
        .padding({
          left: AppSpace.md,
          right: AppSpace.md,
          top: AppSpace.sm,
          bottom: AppSpace.lg
        })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.Spring)

      this.bottomNav()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}