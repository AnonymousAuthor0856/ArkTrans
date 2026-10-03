// MARK: - AppTokens (设计系统令牌)
// 统一管理颜色、字体、形状、间距和阴影，便于全局修改和保持一致性。

// 颜色令牌：使用十六进制字符串表示颜色（对应 SwiftUI 的 Color(red:green:blue:)）。
interface ColorTokens {
  primary: string;
  secondary: string;
  tertiary: string;
  background: string;
  surface: string;
  surfaceVariant: string;
  outline: string;
  success: string;
  warning: string;
  error: string;
  onPrimary: string;
  onSecondary: string;
  onTertiary: string;
  onBackground: string;
  onSurface: string;
}

// 字体令牌：Compose 的 lineHeight 在 ArkUI 中没有直接对应属性，font 本身已包含行高信息。
// letterSpacing 对应 ArkUI 的 letterSpacing。
interface TypographyToken {
  size: number;
  weight: FontWeight;
}

interface TypographyTokens {
  display: TypographyToken;
  headline: TypographyToken;
  title: TypographyToken;
  body: TypographyToken;
  label: TypographyToken;
}

// 圆角形状令牌：cornerRadius 对应 Compose 的 RoundedCornerShape。
interface RoundedCornerShape {
  cornerRadius: number;
}

interface ShapesTokens {
  small: RoundedCornerShape;
  medium: RoundedCornerShape;
  large: RoundedCornerShape;
}

interface SpacingTokens {
  xs: number;
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
}

// 阴影规范：elevation 为 Compose 中的概念层级，ArkUI 通过 radius、offsetY 与颜色透明度实现。
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

interface ElevationMappingTokens {
  level1: ShadowSpec;
  level2: ShadowSpec;
  level3: ShadowSpec;
}

class AppTokens {
  static readonly Colors: ColorTokens = {
    primary: '#020617',
    secondary: '#4ADE80',
    tertiary: '#64748B',
    background: '#F8FAFC',
    surface: '#FFFFFF',
    surfaceVariant: '#F1F5F9',
    outline: '#E2E8F0',
    success: '#22C55E',
    warning: '#F59E0B',
    error: '#EF4444',
    onPrimary: '#FFFFFF',
    onSecondary: '#020617',
    onTertiary: '#FFFFFF',
    onBackground: '#020617',
    onSurface: '#020617'
  };

  static readonly TypographyTokens: TypographyTokens = {
    display: { size: 48, weight: FontWeight.Bold }, // lineHeight = 56.sp, letterSpacing = -0.5.sp
    headline: { size: 28, weight: FontWeight.Medium }, // lineHeight = 36.sp
    title: { size: 20, weight: FontWeight.Medium }, // lineHeight = 28.sp
    body: { size: 16, weight: FontWeight.Regular }, // lineHeight = 24.sp
    label: { size: 12, weight: FontWeight.Medium } // lineHeight = 16.sp, letterSpacing = 0.2.sp
  };

  static readonly Shapes: ShapesTokens = {
    small: { cornerRadius: 8 },
    medium: { cornerRadius: 16 },
    large: { cornerRadius: 24 }
  };

  static readonly Spacing: SpacingTokens = {
    xs: 4,
    sm: 8,
    md: 16,
    lg: 24,
    xl: 32,
    xxl: 48
  };

  static readonly ElevationMapping: ElevationMappingTokens = {
    level1: new ShadowSpec(1, 3, 1, 0.05),
    level2: new ShadowSpec(4, 8, 2, 0.08),
    level3: new ShadowSpec(8, 12, 4, 0.10)
  };
}

// 根据透明度生成黑色阴影颜色字符串（对应 SwiftUI 的 Color.black.opacity(...)）。
function shadowColor(opacity: number): string {
  return 'rgba(0, 0, 0, ' + opacity + ')';
}

// MARK: - Data Models (数据模型)
// 转换为 class，并赋予 id 字段以便在 ForEach 中使用。

class Transaction {
  id: number;
  name: string;
  detail: string;
  amount: string;
  isCredit: boolean;

  constructor(id: number, name: string, detail: string, amount: string, isCredit: boolean) {
    this.id = id;
    this.name = name;
    this.detail = detail;
    this.amount = amount;
    this.isCredit = isCredit;
  }
}

class ControlAction {
  id: number; // 使用自增 id 作为唯一标识符（对应 SwiftUI 的 UUID）
  label: string;

  constructor(label: string) {
    this.id = ControlAction.nextId++;
    this.label = label;
  }

  static nextId: number = 0;
}

class NavItem {
  id: number; // 使用自增 id 作为唯一标识符（对应 SwiftUI 的 UUID）
  label: string;

  constructor(label: string) {
    this.id = NavItem.nextId++;
    this.label = label;
  }

  static nextId: number = 0;
}

// MARK: - RootScreen (主屏幕视图)
@Entry
@Component
struct RootScreen {
  @State selectedNavItem: string = 'Home'; // 对应 Compose 的 remember { mutableStateOf("Home") }

  // 静态数据，对应 Compose 的 remember { listOf(...) }
  transactions: Transaction[] = [
    new Transaction(1, 'Spotify', 'Subscription', '-$9.99', false),
    new Transaction(2, 'Income', 'Monthly Salary', '+$2,500.00', true),
    new Transaction(3, 'Starbucks', 'Coffee', '-$5.75', false),
    new Transaction(4, 'Amazon', 'Shopping', '-$124.50', false),
    new Transaction(5, 'Refund', 'Amazon Return', '+$32.00', true)
  ];

  controlActions: ControlAction[] = [
    new ControlAction('Send'),
    new ControlAction('Receive'),
    new ControlAction('Add'),
    new ControlAction('More')
  ];

  navItems: NavItem[] = [
    new NavItem('Home'),
    new NavItem('Cards'),
    new NavItem('Activity'),
    new NavItem('Profile')
  ];

  build() {
    Stack() {
      Column() {
        // 顶部栏 (TopAppBar)
        this.topAppBar()

        // 主要内容区域 (LazyColumn)
        Scroll() {
          Column({ space: AppTokens.Spacing.lg }) { // verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.lg)
            // 总余额卡片
            this.totalBalanceCard()

            // 控制操作按钮行
            this.controlActionsRow()

            // 最近活动标题
            this.recentActivityHeader()

            // 交易列表
            ForEach(this.transactions, (transaction: Transaction) => {
              this.transactionCard(transaction)
            }, (transaction: Transaction) => transaction.id.toString())
          }
          .padding({
            left: AppTokens.Spacing.md,
            right: AppTokens.Spacing.md,
            top: AppTokens.Spacing.sm,
            bottom: AppTokens.Spacing.sm
          })
        }
        .scrollable(ScrollDirection.Vertical)
        .scrollBar(BarState.Off)
        .layoutWeight(1)
        // 在 ScrollView 底部和导航栏之间添加一些间距，以匹配 Compose 的视觉效果
        .padding({ bottom: AppTokens.Spacing.sm })

        // 底部导航栏 (NavigationBar)
        this.bottomNavigationBar()
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }

  // MARK: - Subviews (子视图)
  // 顶部应用栏
  @Builder
  topAppBar() {
    Row() {
      Button() {
        Circle({ width: 28, height: 28 })
          .fill(AppTokens.Colors.surfaceVariant)
      }
      .backgroundColor(Color.Transparent)
      .padding(0)
      .onClick(() => {})

      Blank()

      Text('My Wallet')
        .fontSize(AppTokens.TypographyTokens.title.size) // MaterialTheme.typography.titleMedium
        .fontWeight(AppTokens.TypographyTokens.title.weight)
        .fontColor(AppTokens.Colors.onBackground)

      Blank()

      Button() {
        Circle({ width: 28, height: 28 })
          .fill(AppTokens.Colors.surfaceVariant)
      }
      .backgroundColor(Color.Transparent)
      .padding(0)
      .onClick(() => {})
    }
    .width('100%')
    .height(56) // 标准 TopAppBar 高度
    .padding({
      left: AppTokens.Spacing.md,
      right: AppTokens.Spacing.md,
      top: AppTokens.Spacing.sm,
      bottom: AppTokens.Spacing.sm
    })
    .backgroundColor(AppTokens.Colors.background) // 透明背景 (background.opacity(0.01))
  }

  // 总余额卡片
  @Builder
  totalBalanceCard() {
    Column({ space: 0 }) {
      Text('Total Balance')
        .fontSize(AppTokens.TypographyTokens.body.size) // MaterialTheme.typography.bodyMedium
        .fontWeight(AppTokens.TypographyTokens.body.weight)
        .fontColor(AppTokens.Colors.onPrimary)
        .opacity(0.7) // onPrimary.opacity(0.7)

      Row().height(AppTokens.Spacing.sm) // Spacer().frame(height: AppTokens.Spacing.sm)

      Text('$ 1,145.14')
        .fontSize(AppTokens.TypographyTokens.display.size) // MaterialTheme.typography.displayLarge
        .fontWeight(AppTokens.TypographyTokens.display.weight)
        .letterSpacing(-0.5) // letterSpacing
        .fontColor(AppTokens.Colors.onPrimary)

      Row().height(AppTokens.Spacing.xs) // Spacer().frame(height: AppTokens.Spacing.xs)

      Row({ space: AppTokens.Spacing.sm }) {
        Circle({ width: 10, height: 10 })
          .fill(AppTokens.Colors.secondary)
        Text('+$234.10 today')
          .fontSize(AppTokens.TypographyTokens.body.size) // MaterialTheme.typography.bodyMedium
          .fontWeight(AppTokens.TypographyTokens.body.weight)
          .fontColor(AppTokens.Colors.secondary)
      }
      .alignItems(VerticalAlign.Center)
    }
    .alignItems(HorizontalAlign.Start) // VStack(alignment: .leading)
    .padding(AppTokens.Spacing.lg)
    .width('100%') // fillMaxWidth()
    .backgroundColor(AppTokens.Colors.primary)
    .borderRadius(AppTokens.Shapes.large.cornerRadius) // shape = AppTokens.Shapes.large
    // elevation = CardDefaults.cardElevation(defaultElevation = AppTokens.ElevationMapping.level2.elevation)
    .shadow({
      radius: AppTokens.ElevationMapping.level2.radius,
      color: shadowColor(AppTokens.ElevationMapping.level2.opacity),
      offsetX: 0,
      offsetY: AppTokens.ElevationMapping.level2.dy
    })
  }

  // 控制操作按钮行
  @Builder
  controlActionsRow() {
    Row({ space: 0 }) { // horizontalArrangement = Arrangement.SpaceAround
      ForEach(this.controlActions, (action: ControlAction) => {
        Column({ space: AppTokens.Spacing.sm }) {
          Button() {
            // 按钮内部的 Box
            Row()
              .width(24)
              .height(24)
              .backgroundColor(AppTokens.Colors.primary)
              .borderRadius(AppTokens.Shapes.small.cornerRadius)
          }
          .width(64)
          .height(64)
          .backgroundColor(AppTokens.Colors.surface) // containerColor
          .borderRadius(32) // shape = CircleShape
          .padding(0) // contentPadding = PaddingValues(0.dp)
          // elevation = ButtonDefaults.buttonElevation(defaultElevation = AppTokens.ElevationMapping.level1.elevation)
          .shadow({
            radius: AppTokens.ElevationMapping.level1.radius,
            color: shadowColor(AppTokens.ElevationMapping.level1.opacity),
            offsetX: 0,
            offsetY: AppTokens.ElevationMapping.level1.dy
          })

          Text(action.label)
            .fontSize(AppTokens.TypographyTokens.label.size) // MaterialTheme.typography.labelMedium
            .fontWeight(AppTokens.TypographyTokens.label.weight)
            .letterSpacing(0.2) // letterSpacing
            .fontColor(AppTokens.Colors.onBackground)
        }
        .layoutWeight(1) // 确保每个 Column 均分空间，实现 SpaceAround
      }, (action: ControlAction) => action.id.toString())
    }
    .alignItems(VerticalAlign.Center)
  }

  // 最近活动标题
  @Builder
  recentActivityHeader() {
    Row() {
      Text('Recent Activity')
        .fontSize(AppTokens.TypographyTokens.title.size) // MaterialTheme.typography.titleMedium
        .fontWeight(AppTokens.TypographyTokens.title.weight)
        .fontColor(AppTokens.Colors.onBackground)

      Blank()

      Button() {
        Text('View All')
          .fontSize(AppTokens.TypographyTokens.label.size) // MaterialTheme.typography.labelMedium
          .fontWeight(AppTokens.TypographyTokens.label.weight)
          .letterSpacing(0.2) // letterSpacing
          .fontColor(AppTokens.Colors.tertiary)
      }
      .backgroundColor(Color.Transparent)
      .padding(0)
      .onClick(() => {})
    }
    .alignItems(VerticalAlign.Center)
  }

  // 交易卡片
  @Builder
  transactionCard(transaction: Transaction) {
    Row({ space: AppTokens.Spacing.md }) {
      // Box(modifier = Modifier.size(48.dp).background(AppTokens.Colors.surfaceVariant, AppTokens.Shapes.medium))
      Row()
        .width(48)
        .height(48)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Shapes.medium.cornerRadius)

      Column() {
        Text(transaction.name)
          .fontSize(AppTokens.TypographyTokens.body.size) // MaterialTheme.typography.bodyMedium
          .fontWeight(FontWeight.Medium) // .semibold
          .fontColor(AppTokens.Colors.onSurface)

        Text(transaction.detail)
          .fontSize(AppTokens.TypographyTokens.label.size) // MaterialTheme.typography.labelMedium
          .fontWeight(AppTokens.TypographyTokens.label.weight)
          .letterSpacing(0.2) // letterSpacing
          .fontColor(AppTokens.Colors.tertiary)
      }
      .layoutWeight(1) // modifier = Modifier.weight(1f)
      .alignItems(HorizontalAlign.Start) // VStack(alignment: .leading)

      Text(transaction.amount)
        .fontSize(AppTokens.TypographyTokens.body.size) // MaterialTheme.typography.bodyMedium
        .fontWeight(FontWeight.Medium) // .semibold
        .fontColor(transaction.isCredit ? AppTokens.Colors.success : AppTokens.Colors.onSurface)
        .textAlign(TextAlign.End) // TextAlign.End
    }
    .alignItems(VerticalAlign.Center)
    .padding(AppTokens.Spacing.md)
    .width('100%') // fillMaxWidth()
    .backgroundColor(AppTokens.Colors.surface) // containerColor
    .borderRadius(AppTokens.Shapes.medium.cornerRadius) // shape = AppTokens.Shapes.medium
    // border = BorderStroke(1.dp, AppTokens.Colors.outline)
    .border({
      width: 1,
      color: AppTokens.Colors.outline,
      radius: AppTokens.Shapes.medium.cornerRadius
    })
  }

  // 底部导航栏
  @Builder
  bottomNavigationBar() {
    Row({ space: 0 }) {
      ForEach(this.navItems, (item: NavItem) => {
        Button() {
          Column({ space: AppTokens.Spacing.xs }) { // 模拟图标和文本的间距
            Circle({ width: 24, height: 24 }) // 图标占位符
              .fill(this.selectedNavItem === item.label ? AppTokens.Colors.primary : AppTokens.Colors.outline)

            Text(item.label)
              .fontSize(AppTokens.TypographyTokens.label.size) // MaterialTheme.typography.labelMedium
              .fontWeight(AppTokens.TypographyTokens.label.weight)
              .letterSpacing(0.2) // letterSpacing
              .fontColor(this.selectedNavItem === item.label ? AppTokens.Colors.primary : AppTokens.Colors.tertiary)
          }
          .width('100%') // 每个导航项均分宽度
          .padding({
            top: AppTokens.Spacing.sm,
            bottom: AppTokens.Spacing.sm
          }) // 模拟 NavigationBarItem 的垂直内边距
          // indicatorColor 模拟，当选中时背景色变为 surfaceVariant
          .backgroundColor(this.selectedNavItem === item.label ? AppTokens.Colors.surfaceVariant : Color.Transparent)
          .borderRadius(AppTokens.Shapes.medium.cornerRadius) // 裁剪指示器背景
        }
        .layoutWeight(1)
        .backgroundColor(Color.Transparent)
        .padding(0)
        .onClick(() => {
          this.selectedNavItem = item.label
        })
      }, (item: NavItem) => item.id.toString())
    }
    .padding({
      left: AppTokens.Spacing.xs,
      right: AppTokens.Spacing.xs
    }) // 整个导航栏的水平内边距
    .height(80) // 模拟 NavigationBar 的高度
    .backgroundColor(AppTokens.Colors.surface) // containerColor
    // tonalElevation 对应阴影效果
    .shadow({
      radius: AppTokens.ElevationMapping.level3.radius,
      color: shadowColor(AppTokens.ElevationMapping.level3.opacity),
      offsetX: 0,
      offsetY: AppTokens.ElevationMapping.level3.dy
    })
  }
}

// MARK: - App Entry Point (应用入口)
// @main 宏在 ArkTS 中由 @Entry 装饰器替代，@Entry 将 RootScreen 标记为应用入口页面，
// 使其成为一个完整的可运行示例。

// MARK: - Preview (预览)
// ArkTS 无 PreviewProvider 对应概念，预览由 DevEco Studio 的 Previewer 提供。
