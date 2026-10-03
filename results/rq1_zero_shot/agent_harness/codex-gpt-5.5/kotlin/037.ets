const NAME: string = '448_BudgetPie_en';
const UI_TYPE: string = 'Finance';
const STYLE_THEME: string = 'Cold Gradient';
const LANG: string = 'en';
const BASELINE_SIZE: string = '720x1280';

class AppColors {
  static readonly primary: string = '#4A5568';
  static readonly secondary: string = '#718096';
  static readonly tertiary: string = '#A0AEC0';
  static readonly background: string = '#F7FAFC';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#EDF2F7';
  static readonly outline: string = '#E2E8F0';
  static readonly success: string = '#48BB78';
  static readonly warning: string = '#F59E0B';
  static readonly error: string = '#F56565';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#FFFFFF';
  static readonly onTertiary: string = '#1A202C';
  static readonly onBackground: string = '#1A202C';
  static readonly onSurface: string = '#1A202C';
  static readonly gradient1: string = '#4299E1';
  static readonly gradient2: string = '#38B2AC';
  static readonly gradient3: string = '#5A67D8';
  static readonly gradient4: string = '#D53F8C';
  static readonly gradient5: string = '#ED8936';
}

class AppSpacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 16;
  static readonly lg: number = 24;
  static readonly xl: number = 32;
  static readonly xxl: number = 48;
}

class BudgetItem {
  name: string;
  value: number;
  color: string;
  constructor(name: string, value: number, color: string) {
    this.name = name;
    this.value = value;
    this.color = color;
  }
}

function formatCurrency(value: number): string {
  return `$${value.toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ',')}`;
}

@Entry
@Component
struct MainActivity {
  private budgetData: BudgetItem[] = [
    new BudgetItem('Housing', 1250.00, AppColors.gradient1),
    new BudgetItem('Food', 480.50, AppColors.gradient2),
    new BudgetItem('Transport', 210.75, AppColors.gradient3),
    new BudgetItem('Entertainment', 150.00, AppColors.gradient4),
    new BudgetItem('Utilities', 320.00, AppColors.gradient5)
  ];

  total(): number {
    let sum = 0;
    this.budgetData.forEach((item: BudgetItem) => sum += item.value);
    return sum;
  }

  @Builder
  Header(): void {
    Text('Monthly Budget')
      .fontSize(24)
      .fontWeight(FontWeight.SemiBold)
      .fontColor(AppColors.primary)
      .width('100%')
      .height(56)
      .textAlign(TextAlign.Center)
      .backgroundColor(AppColors.background);
  }

  @Builder
  PieSummary(): void {
    Stack() {
      Circle().width(240).height(240).fill(AppColors.surfaceVariant);
      Circle().width(180).height(180).fill(AppColors.background);
      Column() {
        Text('Total Spent')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.secondary);
        Text(formatCurrency(this.total()))
          .fontSize(24)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(AppColors.primary);
      }
      .alignItems(HorizontalAlign.Center);
    }
    .width(240)
    .height(240)
    .alignContent(Alignment.Center);
  }

  @Builder
  BudgetRow(item: BudgetItem): void {
    Row() {
      Row({ space: AppSpacing.md }) {
        Circle().width(20).height(20).fill(item.color);
        Text(item.name)
          .fontSize(16)
          .fontColor(AppColors.onSurface);
      }
      .alignItems(VerticalAlign.Center);
      Blank();
      Text(formatCurrency(item.value))
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface);
    }
    .width('100%')
    .padding({ left: AppSpacing.md, right: AppSpacing.md, top: AppSpacing.md, bottom: AppSpacing.md })
    .backgroundColor(AppColors.surface)
    .borderRadius(16)
    .shadow({ radius: 3, color: '#0D000000', offsetY: 1 })
    .alignItems(VerticalAlign.Center);
  }

  @Builder
  BottomBarItem(text: string, active: boolean): void {
    Column({ space: AppSpacing.xs }) {
      Circle()
        .width(24)
        .height(24)
        .fill(active ? '#334A5568' : '#33A0AEC0');
      Text(text)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(active ? AppColors.primary : AppColors.tertiary)
        .textAlign(TextAlign.Center);
    }
    .alignItems(HorizontalAlign.Center);
  }

  @Builder
  BottomBar(): void {
    Row() {
      this.BottomBarItem('Home', true);
      this.BottomBarItem('Reports', false);
      Blank().width(AppSpacing.xl);
      this.BottomBarItem('Goals', false);
      this.BottomBarItem('Settings', false);
    }
    .width('100%')
    .padding({ left: AppSpacing.sm, right: AppSpacing.sm, top: AppSpacing.sm, bottom: AppSpacing.sm })
    .backgroundColor(AppColors.surface)
    .justifyContent(FlexAlign.SpaceAround)
    .alignItems(VerticalAlign.Center)
    .shadow({ radius: 15, color: '#1A000000', offsetY: -5 });
  }

  build() {
    Stack() {
      Column() {
        this.Header();
        Scroll() {
          Column({ space: AppSpacing.md }) {
            this.PieSummary();
            Blank().height(AppSpacing.lg);
            ForEach(this.budgetData, (item: BudgetItem) => {
              this.BudgetRow(item);
            }, (item: BudgetItem) => item.name)
            Blank().height(AppSpacing.xxl);
          }
          .width('100%')
          .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
          .alignItems(HorizontalAlign.Center);
        }
        .layoutWeight(1);
        this.BottomBar();
      }
      Button('+')
        .fontSize(24)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(AppColors.onPrimary)
        .backgroundColor(AppColors.primary)
        .borderRadius(28)
        .width(56)
        .height(56)
        .position({ x: '43%', y: '86%' });
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background);
  }
}
