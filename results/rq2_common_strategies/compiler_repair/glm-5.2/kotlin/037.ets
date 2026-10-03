// Index.ets
interface LinearGradientOption {
  angle: number | string;
  colors: [ResourceColor, number][];
  repeating?: boolean;
}

interface BudgetItem {
  name: string;
  value: number;
  gradient: LinearGradientOption;
}

class AppTokens {
  static readonly primary: string = '#4A5568';
  static readonly secondary: string = '#718096';
  static readonly tertiary: string = '#A0AEC0';
  static readonly background: string = '#F7FAFC';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#EDF2F7';
  static readonly outline: string = '#E2E8F0';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSurface: string = '#1A202C';

  static readonly gradient1: LinearGradientOption = {
    angle: 180,
    colors: [['#63B3ED', 0], ['#4299E1', 1]]
  };
  static readonly gradient2: LinearGradientOption = {
    angle: 180,
    colors: [['#4FD1C5', 0], ['#38B2AC', 1]]
  };
  static readonly gradient3: LinearGradientOption = {
    angle: 180,
    colors: [['#667EEA', 0], ['##5A67D8'.replace('#', '#'), 1]]
  };
  static readonly gradient4: LinearGradientOption = {
    angle: 180,
    colors: [['#ED64A6', 0], ['#D53F8C', 1]]
  };
  static readonly gradient5: LinearGradientOption = {
    angle: 180,
    colors: [['#F6AD55', 0], ['#ED8936', 1]]
  };
}

const budgetData: BudgetItem[] = [
  { name: 'Housing', value: 1250.00, gradient: AppTokens.gradient1 },
  { name: 'Food', value: 480.50, gradient: AppTokens.gradient2 },
  { name: 'Transport', value: 210.75, gradient: AppTokens.gradient3 },
  { name: 'Entertainment', value: 150.00, gradient: AppTokens.gradient4 },
  { name: 'Utilities', value: 320.00, gradient: AppTokens.gradient5 }
];

function formatCurrency(value: number): string {
  return '$' + value.toFixed(2);
}

@Entry
@Component
struct RootScreen {
  @State budgetList: BudgetItem[] = budgetData;

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text('Monthly Budget')
          .fontSize(24)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.primary)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(AppTokens.background)

      // Content List
      Scroll() {
        Column() {
          // Pie Chart
          Stack({ alignContent: Alignment.Center }) {
            // Background Track
            Circle()
              .width(240)
              .height(240)
              .fill(AppTokens.surfaceVariant)

            // Pie Segments
            ForEach(this.budgetList, (item: BudgetItem) => {
              Circle()
                .width(240)
                .height(240)
                .fillOpacity(0)
                .stroke(item.gradient)
                .strokeWidth(20)
            })

            // Center Text
            Column() {
              Text('Total Spent')
                .fontSize(14)
                .fontColor(AppTokens.secondary)
              Text(formatCurrency(this.budgetList.reduce((sum: number, item: BudgetItem) => sum + item.value, 0)))
                .fontSize(24)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppTokens.primary)
            }
          }
          .width(240)
          .height(240)
          .margin({ top: 24, bottom: 24 })

          // Budget Items
          ForEach(this.budgetList, (item: BudgetItem) => {
            Row() {
              Row() {
                Circle()
                  .width(20)
                  .height(20)
                  .fill(item.gradient)
                Text(item.name)
                  .fontSize(16)
                  .fontColor(AppTokens.onSurface)
                  .margin({ left: 16 })
              }

              Text(formatCurrency(item.value))
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppTokens.onSurface)
            }
            .width('100%')
            .padding(16)
            .backgroundColor(AppTokens.surface)
            .borderRadius(16)
            .margin({ bottom: 16 })
            .shadow({ radius: 3, offsetX: 0, offsetY: 1, color: '#0D000000' })
          })

          Blank().height(48)
        }
        .width('100%')
        .padding({ left: 24, right: 24 })
      }
      .layoutWeight(1)
      .backgroundColor(AppTokens.background)
      .align(Alignment.Top)

      // Bottom App Bar
      Row() {
        Column() {
          Circle().width(24).height(24).fill(AppTokens.primary).fillOpacity(0.2)
          Text('Home').fontSize(14).fontColor(AppTokens.primary).margin({ top: 4 })
        }
        Column() {
          Circle().width(24).height(24).fill(AppTokens.tertiary).fillOpacity(0.2)
          Text('Reports').fontSize(14).fontColor(AppTokens.tertiary).margin({ top: 4 })
        }
        Column() {
          Circle().width(24).height(24).fill(AppTokens.tertiary).fillOpacity(0.2)
          Text('Goals').fontSize(14).fontColor(AppTokens.tertiary).margin({ top: 4 })
        }
        Column() {
          Circle().width(24).height(24).fill(AppTokens.tertiary).fillOpacity(0.2)
          Text('Settings').fontSize(14).fontColor(AppTokens.tertiary).margin({ top: 4 })
        }
      }
      .width('100%')
      .height(72)
      .justifyContent(FlexAlign.SpaceAround)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppTokens.surface)
      .shadow({ radius: 15, offsetX: 0, offsetY: -5, color: '#1A000000' })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.background)
  }
}