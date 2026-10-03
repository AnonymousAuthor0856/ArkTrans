/* ------------------------------------------------------------------
 * Retro Filter Search —— SwiftUI ➜ ArkTS / ArkUI 单文件移植
 * 页面入口：RootScreen（@Entry）
 * ------------------------------------------------------------------ */

/* ============================== UI 令牌 ============================== */

class AppColors {
  static readonly primary: string = '#FF7B00';          // #FF7B00
  static readonly secondary: string = '#FFD166';        // #FFD166
  static readonly background: string = '#FFF6E5';       // #FFF6E5
  static readonly surface: string = '#FFFFFF';          // #FFFFFF
  static readonly surfaceVariant: string = '#FFF0C1';   // #FFF0C1
  static readonly outline: string = '#E0C080';          // #E0C080
  static readonly onPrimary: string = '#FFFFFF';        // #FFFFFF
  static readonly onSecondary: string = '#3E2723';      // #3E2723
  static readonly onBackground: string = '#3E2723';     // #3E2723
  static readonly onSurface: string = '#3E2723';        // #3E2723
  static readonly onSurface40: string = '#663E2723';    // onSurface @ 40% 透明度
}

class AppFonts {
  static readonly display: number = 28;
  static readonly headline: number = 20;
  static readonly title: number = 16;
  static readonly body: number = 14;
  static readonly label: number = 12;
}

class AppShapes {
  static readonly small: number = 6;
  static readonly medium: number = 10;
  static readonly large: number = 14;
}

class AppSpacing {
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
}

class AppElevation {
  static readonly level2Radius: number = 8;             // 阴影模糊半径
  static readonly level2Dy: number = 4;                 // Y 轴偏移
  static readonly level2Color: string = '#1F000000';    // black @ 12%
}

/* ============================== 数据模型 ============================== */

class ResultItem {
  id: number;
  title: string;

  constructor(id: number, title: string) {
    this.id = id;
    this.title = title;
  }
}

/* ============================== 卡片组件 ============================== */

@Component
struct CardView {
  item: ResultItem = new ResultItem(0, '');

  build() {
    Column({ space: AppSpacing.sm }) {
      // 图片占位符
      Column()
        .width(96)
        .height(96)
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(AppShapes.medium)

      Text(this.item.title)
        .fontSize(AppFonts.title)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)

      // 添加按钮
      Button('Add')
        .type(ButtonType.Normal)
        .fontSize(AppFonts.label)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .backgroundColor(AppColors.primary)
        .borderRadius(AppShapes.medium)
        .width('100%')
        .height(40)
        .onClick(() => {
        })
    }
    .alignItems(HorizontalAlign.Center)
    .padding(AppSpacing.lg)
    .width('100%')
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.large)
    .shadow({
      radius: AppElevation.level2Radius,
      color: AppElevation.level2Color,
      offsetX: 0,
      offsetY: AppElevation.level2Dy
    })
  }
}

/* ============================== 根页面 ============================== */

@Entry
@Component
struct RootScreen {
  @State query: string = '';
  @State isFocused: boolean = false;

  // 可拖动旋钮的坐标（Canvas 内部坐标系，单位 vp）
  @State knobX: number = 144;
  @State knobY: number = 104;

  private filters: string[] = ['Popular', 'New', 'Discount', 'Premium'];
  private resultRows: ResultItem[][] = [];

  private dragStartX: number = 0;
  private dragStartY: number = 0;

  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  aboutToAppear(): void {
    const flat: ResultItem[] = [];
    for (let i = 0; i < 6; i++) {
      flat.push(new ResultItem(i, 'Result ' + (i + 1)));
    }
    // LazyVerticalGrid 的两列 → 按行分组
    const rows: ResultItem[][] = [];
    for (let i = 0; i < flat.length; i += 2) {
      rows.push(flat.slice(i, i + 2));
    }
    this.resultRows = rows;
  }

  /** 绘制背景矩形 + 径向渐变圆 + 旋钮 */
  private drawCanvas(): void {
    const w: number = this.ctx.width;
    const h: number = this.ctx.height;
    if (w <= 0 || h <= 0) {
      return;
    }

    // 背景矩形
    this.ctx.clearRect(0, 0, w, h);
    this.ctx.fillStyle = AppColors.surfaceVariant;
    this.ctx.fillRect(0, 0, w, h);

    // 径向渐变圆
    const cx: number = w / 2;
    const cy: number = h / 2;
    const r: number = 60;
    const gradient: CanvasGradient = this.ctx.createRadialGradient(cx, cy, 0, cx, cy, r);
    gradient.addColorStop(0, AppColors.secondary);
    gradient.addColorStop(1, AppColors.primary);
    this.ctx.beginPath();
    this.ctx.arc(cx, cy, r, 0, Math.PI * 2);
    this.ctx.fillStyle = gradient;
    this.ctx.fill();

    // 旋钮
    this.ctx.beginPath();
    this.ctx.arc(this.knobX, this.knobY, 16, 0, Math.PI * 2);
    this.ctx.fillStyle = AppColors.primary;
    this.ctx.fill();
  }

  build() {
    Scroll() {
      Column({ space: AppSpacing.md }) {

        // 标题
        Text('Retro Filter Search')
          .fontSize(AppFonts.display)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onBackground)
          .width('100%')
          .textAlign(TextAlign.Start)

        // 搜索输入框
        TextInput({ placeholder: 'Search products', text: this.query })
          .type(InputType.Normal)
          .fontSize(AppFonts.body)
          .fontColor(AppColors.onSurface)
          .placeholderFont({ size: AppFonts.body })
          .placeholderColor(AppColors.onSurface40)
          .caretColor(AppColors.primary)
          .height(56)
          .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
          .backgroundColor(AppColors.surface)
          .borderRadius(AppShapes.medium)
          .borderWidth(1)
          .borderColor(this.isFocused ? AppColors.primary : AppColors.outline)
          .onChange((value: string) => {
            this.query = value;
          })
          .onFocus(() => {
            this.isFocused = true;
          })
          .onBlur(() => {
            this.isFocused = false;
          })

        // 筛选按钮行
        Row({ space: AppSpacing.sm }) {
          ForEach(this.filters, (label: string) => {
            Button(label)
              .type(ButtonType.Normal)
              .fontSize(AppFonts.label)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.onSecondary)
              .backgroundColor(AppColors.secondary)
              .borderRadius(AppShapes.small)
              .height(36)
              .padding({ left: AppSpacing.md, right: AppSpacing.md })
              .onClick(() => {
              })
          }, (label: string) => label)
        }
        .width('100%')
        .justifyContent(FlexAlign.Start)

        // Canvas 区域
        Stack() {
          Canvas(this.ctx)
            .width('100%')
            .height('100%')
            .padding(AppSpacing.lg)
            .onReady(() => {
              this.drawCanvas();
            })
            .gesture(
              PanGesture()
                .onActionStart(() => {
                  this.dragStartX = this.knobX;
                  this.dragStartY = this.knobY;
                })
                .onActionUpdate((event: GestureEvent) => {
                  const radius: number = 16;
                  const maxX: number = Math.max(radius, this.ctx.width - radius);
                  const maxY: number = Math.max(radius, this.ctx.height - radius);
                  this.knobX = Math.min(Math.max(this.dragStartX + event.offsetX, radius), maxX);
                  this.knobY = Math.min(Math.max(this.dragStartY + event.offsetY, radius), maxY);
                  this.drawCanvas();
                })
            )
        }
        .width('100%')
        .height(180)
        .backgroundColor(AppColors.surface)
        .borderRadius(AppShapes.large)

        // 结果网格（两列）
        Column({ space: AppSpacing.lg }) {
          ForEach(this.resultRows, (row: ResultItem[], index: number) => {
            Row({ space: AppSpacing.lg }) {
              ForEach(row, (item: ResultItem) => {
                Column() {
                  CardView({ item: item })
                }
                .layoutWeight(1)
              }, (item: ResultItem) => item.id.toString())
            }
            .width('100%')
            .alignItems(VerticalAlign.Top)
          }, (row: ResultItem[], index: number) => index.toString())
        }
        .width('100%')
      }
      .width('100%')
      .padding({
        left: AppSpacing.lg,
        right: AppSpacing.lg,
        top: AppSpacing.lg,
        bottom: 24
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
    .scrollBar(BarState.Off)
    .edgeEffect(EdgeEffect.Spring)
  }
}