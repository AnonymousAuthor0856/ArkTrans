// ============================================================================
// Index.ets  —  Kanban Board (SwiftUI -> ArkTS / ArkUI 声明式范式)
// 建议放在 src/main/ets/pages/Index.ets
// 全屏 + 隐藏状态栏由 EntryAbility 中的窗口设置完成（见文件末尾）
// ============================================================================

// MARK: - Design Tokens（Hex -> 0x25/0x63/0xEB 等逐值转换；Dp 与 Sp 1:1 -> vp/fp）

export class AppTokens {
  // ---- Colors ----
  static readonly colorPrimary: string = '#2563EB';          // 0x25,0x63,0xEB
  static readonly colorSecondary: string = '#60A5FA';        // 0x60,0xA5,0xFA
  static readonly colorTertiary: string = '#3B82F6';         // 0x3B,0x82,0xF6
  static readonly colorBackground: string = '#F3F4F6';       // 0xF3,0xF4,0xF6
  static readonly colorSurface: string = '#FFFFFF';          // 0xFF,0xFF,0xFF
  static readonly colorSurfaceVariant: string = '#E5E7EB';   // 0xE5,0xE7,0xEB
  static readonly colorOutline: string = '#D1D5DB';          // 0xD1,0xD5,0xDB
  static readonly colorSuccess: string = '#16A34A';          // 0x16,0xA3,0x4A
  static readonly colorWarning: string = '#F59E0B';          // 0xF5,0x9E,0x0B
  static readonly colorError: string = '#DC2626';            // 0xDC,0x26,0x26
  static readonly colorOnPrimary: string = '#FFFFFF';
  static readonly colorOnSecondary: string = '#1E1E1E';
  static readonly colorOnTertiary: string = '#FFFFFF';
  static readonly colorOnBackground: string = '#1E1E1E';
  static readonly colorOnSurface: string = '#1E1E1E';

  // ---- Typography (size / weight) ----
  static readonly fontDisplaySize: number = 28;   // display, Bold
  static readonly fontTitleSize: number = 18;     // title, Medium
  static readonly fontBodySize: number = 14;      // body, Normal
  static readonly fontLabelSize: number = 12;     // label, Medium

  // ---- Shapes ----
  static readonly radiusSmall: number = 6;
  static readonly radiusMedium: number = 10;
  static readonly radiusLarge: number = 14;

  // ---- Spacing ----
  static readonly spacingXs: number = 4;
  static readonly spacingSm: number = 8;
  static readonly spacingMd: number = 12;
  static readonly spacingLg: number = 16;
  static readonly spacingXl: number = 24;

  // ---- Elevation (level1: elev 2 / radius 4 / dy 2 / alpha .12) ----
  static readonly elevation1Radius: number = 4;
  static readonly elevation1Dy: number = 2;
  static readonly elevation1Color: string = 'rgba(0, 0, 0, 0.12)';

  // ---- Elevation (level2: elev 4 / radius 8 / dy 4 / alpha .16) ----
  static readonly elevation2Radius: number = 8;
  static readonly elevation2Dy: number = 4;
  static readonly elevation2Color: string = 'rgba(0, 0, 0, 0.16)';
}

// MARK: - Data Models

export class KanbanColumn {
  title: string;
  tasks: string[];

  constructor(title: string, tasks: string[]) {
    this.title = title;
    this.tasks = tasks;
  }
}

// MARK: - AssistChip（对应 AssistChipView）

@Component
struct AssistChip {
  task: string = '';

  build() {
    Row() {
      Text(this.task)
        .fontSize(AppTokens.fontBodySize)
        .fontWeight(FontWeight.Normal)
        .fontColor(AppTokens.colorOnSurface)
    }
    .padding({
      left: AppTokens.spacingLg,
      right: AppTokens.spacingLg,
      top: AppTokens.spacingSm,
      bottom: AppTokens.spacingSm
    })
    .backgroundColor(AppTokens.colorSurfaceVariant)
    .borderRadius(AppTokens.radiusMedium)
    .onClick(() => {
      // 与原版一致：onClick 为空实现
    })
  }
}

// MARK: - CardView（对应 Kanban Column Card）

@Component
struct KanbanCard {
  column: KanbanColumn = new KanbanColumn('', []);

  build() {
    Column({ space: AppTokens.spacingSm }) {
      Text(this.column.title)
        .fontSize(AppTokens.fontTitleSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.colorPrimary)

      ForEach(this.column.tasks, (task: string) => {
        AssistChip({ task: task })
      }, (task: string, index: number) => `${index}-${task}`)
    }
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.Start) // 等价于 SwiftUI 末尾的 Spacer()：内容顶对齐
    .padding(AppTokens.spacingMd)
    .width(220)                       // 与 Kotlin 版本一致的固定宽度
    .height('100%')                   // 等价于 .frame(maxHeight: .infinity)
    .backgroundColor(AppTokens.colorSurface)
    .borderRadius(AppTokens.radiusLarge)
    .shadow({
      radius: AppTokens.elevation2Radius,
      color: AppTokens.elevation2Color,
      offsetX: 0,
      offsetY: AppTokens.elevation2Dy
    })
  }
}

// MARK: - RootScreen（对应 RootScreen）

@Entry
@Component
struct RootScreen {
  @State notificationsEnabled: boolean = true;

  private columns: KanbanColumn[] = [
    new KanbanColumn('To Do', ['Write report', 'Design mockup']),
    new KanbanColumn('In Progress', ['Implement feature X', 'Fix layout bug']),
    new KanbanColumn('Done', ['Team sync', 'Client feedback'])
  ];

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // 全屏背景
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(AppTokens.colorBackground)

      Column() {
        // ---- 自定义顶部栏（CenterAlignedTopAppBar）----
        Row() {
          Text('Kanban Board')
            .fontSize(AppTokens.fontDisplaySize)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppTokens.colorOnSurface)
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
        .padding({
          left: AppTokens.spacingLg,
          right: AppTokens.spacingLg,
          top: AppTokens.spacingLg,
          bottom: AppTokens.spacingMd
        })
        .backgroundColor(AppTokens.colorBackground)

        // ---- 主内容区 ----
        Column({ space: AppTokens.spacingLg }) {
          // 通知行
          Row() {
            Text('Notifications')
              .fontSize(AppTokens.fontTitleSize)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.colorOnSurface)

            Blank()

            Toggle({ type: ToggleType.Switch, isOn: this.notificationsEnabled })
              .selectedColor(AppTokens.colorPrimary)
              .onChange((isOn: boolean) => {
                this.notificationsEnabled = isOn;
              })
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)

          // ---- Kanban 列的 LazyRow 等效 ----
          Scroll() {
            Row({ space: AppTokens.spacingMd }) {
              ForEach(this.columns, (col: KanbanColumn) => {
                KanbanCard({ column: col })
              }, (col: KanbanColumn) => col.title)
            }
            .height('100%')
            .alignItems(VerticalAlign.Top)
            .padding({ top: AppTokens.spacingXs, bottom: AppTokens.spacingXs })
          }
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)
          .edgeEffect(EdgeEffect.Spring)
          .width('100%')
          .layoutWeight(1)

          // ---- Task Completion ----
          Text('Task Completion')
            .fontSize(AppTokens.fontTitleSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.colorOnSurface)

          // ---- LinearProgressIndicator 等效（进度 0.65，高度 8dp）----
          Stack({ alignContent: Alignment.Start }) {
            Row()
              .width('100%')
              .height(8)
              .backgroundColor(AppTokens.colorSurfaceVariant)
              .borderRadius(4)

            Row()
              .width('65%')
              .height(8)
              .backgroundColor(AppTokens.colorPrimary)
              .borderRadius(4)
          }
          .width('100%')
          .height(8)
        }
        .alignItems(HorizontalAlign.Start)
        .padding(AppTokens.spacingLg)
        .width('100%')
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.colorBackground)
  }
}

// ============================================================================
// EntryAbility.ets —— 要求2：全屏显示 + 隐藏顶部状态栏
// 把下面两行放进 onWindowStageCreate 中（loadContent 之后）
// ============================================================================
//
// import { window } from '@kit.ArkUI';
//
// onWindowStageCreate(windowStage: window.WindowStage): void {
//   windowStage.loadContent('pages/Index', (err) => {
//     if (err.code) { return; }
//   });
//   const mainWindow = windowStage.getMainWindowSync();
//   mainWindow.setWindowLayoutFullScreen(true);   // 内容延伸到全部安全区域外
//   mainWindow.setWindowSystemBarEnable([]);      // 隐藏状态栏（按需保留导航栏可写 ['navigation'])
// }