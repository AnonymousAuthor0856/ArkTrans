import window from '@ohos.window';

// ===== 设计令牌 AppTokens =====
const COLOR_PRIMARY: string = '#38BDF8';
const COLOR_SECONDARY: string = '#6366F1';
const COLOR_TERTIARY: string = '#A5B4FC';
const COLOR_BACKGROUND: string = '#F1F5F9';
const COLOR_SURFACE: string = '#FFFFFF';
const COLOR_SURFACE_70: string = '#B3FFFFFF';   // surface @ 70%
const COLOR_SURFACE_VARIANT: string = '#E2E8F0';
const COLOR_OUTLINE: string = '#D1D5DB';
const COLOR_ON_SURFACE: string = '#1E1E1E';
const COLOR_ON_PRIMARY: string = '#FFFFFF';
const COLOR_SHADOW_L1: string = '#1F000000';    // black @ 12%

const FONT_DISPLAY: number = 26;
const FONT_TITLE: number = 18;
const FONT_BODY: number = 14;
const FONT_LABEL: number = 12;

const RADIUS_SMALL: number = 6;
const RADIUS_MEDIUM: number = 10;
const RADIUS_LARGE: number = 16;

const SPACING_XS: number = 4;
const SPACING_SM: number = 8;
const SPACING_MD: number = 12;
const SPACING_LG: number = 16;
const SPACING_XL: number = 24;

// ===== 数据模型 =====
interface TaskItem {
  name: string;
  progress: number; // 0.0 ~ 1.0
}

@Entry
@Component
struct ProjectTimeline {
  @State tasks: TaskItem[] = [
    { name: 'Design Phase', progress: 0.8 },
    { name: 'Development', progress: 0.5 },
    { name: 'Testing', progress: 0.3 },
    { name: 'Documentation', progress: 0.6 },
    { name: 'Deployment', progress: 0.2 }
  ];

  @State notificationsEnabled: boolean = true;

  aboutToAppear(): void {
    // 隐藏状态栏 / 导航栏并全屏布局，对应 SwiftUI 的 .statusBarHidden(true)
    window.getLastWindow(getContext(this))
      .then((win: window.Window) => {
        win.setWindowLayoutFullScreen(true);
        win.setWindowSystemBarEnable([]);
      })
      .catch((err: Error) => {
        console.error(`setWindowLayoutFullScreen failed: ${err.message}`);
      });
  }

  // 自定义线性进度条（对应 CustomLinearProgressViewStyle）
  @Builder
  LinearProgressBar(progress: number) {
    Stack({ alignContent: Alignment.Start }) {
      Row()
        .width('100%')
        .height(8)
        .backgroundColor(COLOR_SURFACE_VARIANT)
        .borderRadius(4)

      Row()
        .width((progress * 100).toFixed(0) + '%')
        .height(8)
        .backgroundColor(COLOR_SECONDARY)
        .borderRadius(4)
    }
    .width('100%')
    .height(8)
  }

  // 单个任务卡片
  @Builder
  TaskCard(item: TaskItem) {
    Column({ space: SPACING_SM }) {
      Text(item.name)
        .fontSize(FONT_TITLE)
        .fontWeight(FontWeight.Medium)
        .fontColor(COLOR_PRIMARY)

      this.LinearProgressBar(item.progress)
    }
    .alignItems(HorizontalAlign.Start)
    .padding(SPACING_MD)
    .width('100%')
    .backgroundColor(COLOR_SURFACE_70)
    .borderRadius(RADIUS_LARGE)
    .shadow({
      radius: 4,
      color: COLOR_SHADOW_L1,
      offsetX: 0,
      offsetY: 2
    })
  }

  build() {
    Column() {
      // 顶部标题栏（CenterAlignedTopAppBar）
      Text('Project Timeline')
        .fontSize(FONT_DISPLAY)
        .fontWeight(FontWeight.Bold)
        .fontColor(COLOR_ON_SURFACE)
        .textAlign(TextAlign.Center)
        .width('100%')
        .padding({ top: SPACING_LG + SPACING_SM, bottom: SPACING_LG })
        .backgroundColor(COLOR_BACKGROUND)

      // 主要内容区域
      Column({ space: SPACING_LG }) {
        // 通知开关行
        Row() {
          Text('Notifications')
            .fontSize(FONT_TITLE)
            .fontWeight(FontWeight.Medium)
            .fontColor(COLOR_ON_SURFACE)

          Blank()

          Toggle({ type: ToggleType.Switch, isOn: this.notificationsEnabled })
            .selectedColor(COLOR_PRIMARY)
            .switchPointColor(COLOR_SURFACE)
            .width(51)
            .height(31)
            .onChange((isOn: boolean) => {
              this.notificationsEnabled = isOn;
            })
        }
        .width('100%')

        // 任务列表（LazyColumn → List）
        List({ space: SPACING_MD }) {
          ForEach(this.tasks, (item: TaskItem) => {
            ListItem() {
              this.TaskCard(item)
            }
          }, (item: TaskItem) => item.name)
        }
        .width('100%')
        .layoutWeight(1)
        .scrollBar(BarState.Off)
        .edgeEffect(EdgeEffect.Spring)

        // Add Task 按钮
        Button('Add Task', { type: ButtonType.Normal, stateEffect: true })
          .fontSize(FONT_TITLE)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLOR_ON_PRIMARY)
          .width('100%')
          .height(52)
          .backgroundColor(COLOR_PRIMARY)
          .borderRadius(RADIUS_LARGE)
          .onClick(() => {
            console.info('Add Task button tapped!');
          })
      }
      .width('100%')
      .layoutWeight(1)
      .padding(SPACING_LG)
      .linearGradient({
        angle: 180,
        colors: [
          [COLOR_SURFACE_70, 0.0],
          [COLOR_BACKGROUND, 0.5],
          [COLOR_SURFACE_70, 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLOR_BACKGROUND)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}