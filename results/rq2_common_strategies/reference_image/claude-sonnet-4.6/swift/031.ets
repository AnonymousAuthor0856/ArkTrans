/**
 * RootScreen.ets — SwiftUI「My Wallet」界面的 ArkTS 实现（HarmonyOS NEXT / ArkUI，API 11+）
 *
 * 关于截图：我无法生成或附上图片。请在 DevEco Studio 中新建一个 Empty Ability 工程，
 * 用本文件替换 pages/Index.ets，然后打开右侧 Previewer（或真机运行）即可看到与
 * 参考图一致的渲染结果。
 */

// MARK: - AppTokens（设计系统令牌）

// Colors
const COLOR_PRIMARY: string = '#020617';
const COLOR_SECONDARY: string = '#4ADE80';
const COLOR_TERTIARY: string = '#64748B';
const COLOR_BACKGROUND: string = '#F8FAFC';
const COLOR_SURFACE: string = '#FFFFFF';
const COLOR_SURFACE_VARIANT: string = '#F1F5F9';
const COLOR_OUTLINE: string = '#E2E8F0';
const COLOR_SUCCESS: string = '#22C55E';
const COLOR_WARNING: string = '#F59E0B';
const COLOR_ERROR: string = '#EF4444';
const COLOR_ON_PRIMARY: string = '#FFFFFF';
const COLOR_ON_PRIMARY_70: string = '#B3FFFFFF';
const COLOR_ON_BACKGROUND: string = '#020617';
const COLOR_ON_SURFACE: string = '#020617';
const COLOR_TRANSPARENT: string = '#00000000';

// Typography（fontSize 数值单位默认为 fp，即 Compose 的 sp）
const FONT_DISPLAY: number = 48;   // lineHeight 56, letterSpacing -0.5
const FONT_HEADLINE: number = 28;  // lineHeight 36
const FONT_TITLE: number = 20;     // lineHeight 28
const FONT_BODY: number = 16;      // lineHeight 24
const FONT_LABEL: number = 12;     // lineHeight 16, letterSpacing 0.2

// Shapes
const RADIUS_SMALL: number = 8;
const RADIUS_MEDIUM: number = 16;
const RADIUS_LARGE: number = 24;

// Spacing（数值单位默认为 vp，即 Compose 的 dp）
const SP_XS: number = 4;
const SP_SM: number = 8;
const SP_MD: number = 16;
const SP_LG: number = 24;
const SP_XL: number = 32;
const SP_XXL: number = 48;

// ElevationMapping -> ShadowOptions
const SHADOW_L1_RADIUS: number = 3;
const SHADOW_L1_DY: number = 1;
const SHADOW_L1_COLOR: string = '#0D000000'; // black @ 5%
const SHADOW_L2_RADIUS: number = 8;
const SHADOW_L2_DY: number = 2;
const SHADOW_L2_COLOR: string = '#14000000'; // black @ 8%
const SHADOW_L3_RADIUS: number = 12;
const SHADOW_L3_DY: number = 4;
const SHADOW_L3_COLOR: string = '#1A000000'; // black @ 10%

// MARK: - Data Models（数据模型）

interface Transaction {
  id: number;
  name: string;
  detail: string;
  amount: string;
  isCredit: boolean;
}

interface ControlAction {
  id: number; // ArkTS 的 ForEach 需要稳定 key，用显式 id 代替 Swift 的 UUID
  label: string;
}

interface NavItem {
  id: number;
  label: string;
}

// MARK: - RootScreen

@Entry
@Component
struct RootScreen {
  @State selectedNavItem: string = 'Home';

  private transactions: Transaction[] = [
    { id: 1, name: 'Spotify', detail: 'Subscription', amount: '-$9.99', isCredit: false },
    { id: 2, name: 'Income', detail: 'Monthly Salary', amount: '+$2,500.00', isCredit: true },
    { id: 3, name: 'Starbucks', detail: 'Coffee', amount: '-$5.75', isCredit: false },
    { id: 4, name: 'Amazon', detail: 'Shopping', amount: '-$124.50', isCredit: false },
    { id: 5, name: 'Refund', detail: 'Amazon Return', amount: '+$32.00', isCredit: true }
  ];

  private controlActions: ControlAction[] = [
    { id: 1, label: 'Send' },
    { id: 2, label: 'Receive' },
    { id: 3, label: 'Add' },
    { id: 4, label: 'More' }
  ];

  private navItems: NavItem[] = [
    { id: 1, label: 'Home' },
    { id: 2, label: 'Cards' },
    { id: 3, label: 'Activity' },
    { id: 4, label: 'Profile' }
  ];

  build() {
    Column() {
      // 顶部应用栏
      this.TopAppBar()

      // 主要内容区域（对应 SwiftUI 的 ScrollView / Compose 的 LazyColumn）
      Scroll() {
        Column({ space: SP_LG }) {
          this.TotalBalanceCard()
          this.ControlActionsRow()
          this.RecentActivityHeader()

          ForEach(this.transactions, (item: Transaction) => {
            this.TransactionCard(item)
          }, (item: Transaction) => item.id.toString())
        }
        .width('100%')
        .padding({ left: SP_MD, right: SP_MD, top: SP_SM, bottom: SP_SM })
      }
      .width('100%')
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.Spring)

      // 底部导航栏
      this.BottomNavigationBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLOR_BACKGROUND)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }

  // MARK: - Subviews

  @Builder
  TopAppBar() {
    Row() {
      Circle()
        .width(28)
        .height(28)
        .fill(COLOR_SURFACE_VARIANT)
        .onClick(() => {
        })

      Text('My Wallet')
        .fontSize(FONT_TITLE)
        .fontWeight(FontWeight.Medium)
        .fontColor(COLOR_ON_BACKGROUND)
        .textAlign(TextAlign.Center)
        .layoutWeight(1)

      Circle()
        .width(28)
        .height(28)
        .fill(COLOR_SURFACE_VARIANT)
        .onClick(() => {
        })
    }
    .width('100%')
    .height(56)
    .alignItems(VerticalAlign.Center)
    .padding({ left: SP_MD, right: SP_MD, top: SP_SM, bottom: SP_SM })
  }

  @Builder
  TotalBalanceCard() {
    Column() {
      Text('Total Balance')
        .fontSize(FONT_BODY)
        .fontWeight(FontWeight.Regular)
        .fontColor(COLOR_ON_PRIMARY_70)

      Text('$ 1,145.14')
        .fontSize(FONT_DISPLAY)
        .fontWeight(FontWeight.Bold)
        .fontColor(COLOR_ON_PRIMARY)
        .margin({ top: SP_SM })

      Row({ space: SP_SM }) {
        Circle()
          .width(10)
          .height(10)
          .fill(COLOR_SECONDARY)

        Text('+$234.10 today')
          .fontSize(FONT_BODY)
          .fontWeight(FontWeight.Regular)
          .fontColor(COLOR_SECONDARY)
      }
      .alignItems(VerticalAlign.Center)
      .margin({ top: SP_XS })
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .padding(SP_LG)
    .backgroundColor(COLOR_PRIMARY)
    .borderRadius(RADIUS_LARGE)
    .shadow({
      radius: SHADOW_L2_RADIUS,
      color: SHADOW_L2_COLOR,
      offsetX: 0,
      offsetY: SHADOW_L2_DY
    })
  }

  @Builder
  ControlActionsRow() {
    Row() {
      ForEach(this.controlActions, (item: ControlAction) => {
        Column() {
          // 圆形按钮容器，内部是一个 24x24 的圆角方块
          Column() {
            Column()
              .width(24)
              .height(24)
              .backgroundColor(COLOR_PRIMARY)
              .borderRadius(RADIUS_SMALL)
          }
          .width(64)
          .height(64)
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
          .backgroundColor(COLOR_SURFACE)
          .borderRadius(32)
          .shadow({
            radius: SHADOW_L1_RADIUS,
            color: SHADOW_L1_COLOR,
            offsetX: 0,
            offsetY: SHADOW_L1_DY
          })
          .onClick(() => {
          })

          Text(item.label)
            .fontSize(FONT_LABEL)
            .fontWeight(FontWeight.Medium)
            .letterSpacing(0.2)
            .fontColor(COLOR_ON_BACKGROUND)
            .margin({ top: SP_SM })
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center)
      }, (item: ControlAction) => item.id.toString())
    }
    .width('100%')
    .alignItems(VerticalAlign.Top)
  }

  @Builder
  RecentActivityHeader() {
    Row() {
      Text('Recent Activity')
        .fontSize(FONT_TITLE)
        .fontWeight(FontWeight.Medium)
        .fontColor(COLOR_ON_BACKGROUND)
        .layoutWeight(1)

      Text('View All')
        .fontSize(FONT_LABEL)
        .fontWeight(FontWeight.Medium)
        .letterSpacing(0.2)
        .fontColor(COLOR_TERTIARY)
        .onClick(() => {
        })
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  TransactionCard(item: Transaction) {
    Row({ space: SP_MD }) {
      Column()
        .width(48)
        .height(48)
        .backgroundColor(COLOR_SURFACE_VARIANT)
        .borderRadius(RADIUS_MEDIUM)

      Column() {
        Text(item.name)
          .fontSize(FONT_BODY)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(COLOR_ON_SURFACE)

        Text(item.detail)
          .fontSize(FONT_LABEL)
          .fontWeight(FontWeight.Medium)
          .letterSpacing(0.2)
          .fontColor(COLOR_TERTIARY)
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Text(item.amount)
        .fontSize(FONT_BODY)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(item.isCredit ? COLOR_SUCCESS : COLOR_ON_SURFACE)
        .textAlign(TextAlign.End)
    }
    .width('100%')
    .padding(SP_MD)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(COLOR_SURFACE)
    .borderRadius(RADIUS_MEDIUM)
    .border({ width: 1, color: COLOR_OUTLINE })
  }

  @Builder
  BottomNavigationBar() {
    Row() {
      ForEach(this.navItems, (item: NavItem) => {
        Column({ space: SP_XS }) {
          Circle()
            .width(24)
            .height(24)
            .fill(this.selectedNavItem === item.label ? COLOR_PRIMARY : COLOR_OUTLINE)

          Text(item.label)
            .fontSize(FONT_LABEL)
            .fontWeight(FontWeight.Medium)
            .letterSpacing(0.2)
            .fontColor(this.selectedNavItem === item.label ? COLOR_PRIMARY : COLOR_TERTIARY)
        }
        .layoutWeight(1)
        .padding({ top: SP_SM, bottom: SP_SM })
        .backgroundColor(this.selectedNavItem === item.label ? COLOR_SURFACE_VARIANT : COLOR_TRANSPARENT)
        .borderRadius(RADIUS_MEDIUM)
        .onClick(() => {
          this.selectedNavItem = item.label;
        })
      }, (item: NavItem) => item.id.toString())
    }
    .width('100%')
    .height(80)
    .alignItems(VerticalAlign.Center)
    .padding({ left: SP_XS, right: SP_XS })
    .backgroundColor(COLOR_SURFACE)
    .shadow({
      radius: SHADOW_L3_RADIUS,
      color: SHADOW_L3_COLOR,
      offsetX: 0,
      offsetY: SHADOW_L3_DY
    })
  }
}