// MARK: - Color Palette (Custom Muted Earth Tones)
// 扩展 Color 以定义应用中使用的所有自定义颜色
class ZenColors {
  static readonly zenGreen: string = '#6A8E6A';
  static readonly zenGreenLight: string = '#E8F5E9';
  static readonly zenBrown: string = '#8D6E63';
  static readonly zenTextPrimary: string = '#2C3E50';
  static readonly zenTextSecondary: string = '#7F8C8D';
  static readonly zenWhite: string = '#FFFFFF';
  static readonly zenAccent: string = '#D4E157';

  // 从 Kotlin 代码中提取的额外颜色
  static readonly statusItemBg: string = '#F7F9F9';
  static readonly statusItemBorder: string = '#ECEFF1';
  static readonly careLogBg: string = '#FAFAFA';
  static readonly careLogBorder: string = '#F0F0F0';
  static readonly careLogSubtitle: string = '#9E9E9E';
  static readonly navIconInactive: string = '#CFD8DC';
  static readonly bottomBarDivider: string = '#F5F5F5';
  static readonly lightGrayCircle: string = '#E0E0E0';
  static readonly trunkColor: string = '#5D4037';
  static readonly healthRed: string = '#E57373';
  static readonly waterBlue: string = '#64B5F6';
}

// MARK: - Typography Mapping
// 定义应用中使用的字体样式，以便于统一管理和修改
class AppTypography {
  static readonly labelMediumSize: number = 12;
  static readonly labelMediumWeight: number = 500;
  static readonly displaySmallLightSize: number = 36;
  static readonly displaySmallLightWeight: number = 300;
  static readonly titleMediumBoldSize: number = 16;
  static readonly titleMediumBoldWeight: number = 700;
  static readonly titleMediumSemiBoldSize: number = 16;
  static readonly titleMediumSemiBoldWeight: number = 600;
  static readonly labelSmallSize: number = 11;
  static readonly labelSmallWeight: number = 400;
  static readonly bodyMediumSize: number = 14;
  static readonly bodyMediumWeight: number = 400;
}

// MARK: - Main App Entry Point
// @main 标记 ZenBonsaiApp 为应用的入口
@Entry
@Component
struct ZenBonsaiApp {
  build() {
    Column() {
      ZenBonsaiAppView()
        // 确保内容延伸到屏幕边缘，忽略所有安全区域
        .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM, SafeAreaEdge.START, SafeAreaEdge.END])
    }
    .width('100%')
    .height('100%')
    // 隐藏顶部状态栏（ArkUI 无等价的声明式修饰符，需通过窗口 API setWindowSystemBarProperties 实现）
  }
}

// MARK: - ZenBonsaiAppView (Main Content View)
@Component
struct ZenBonsaiAppView {
  build() {
    // 使用 Stack 将底部导航栏叠加在主内容之上
    Stack({ alignContent: Alignment.Bottom }) {
      // Scroll 允许主内容滚动
      Scroll() {
        // 主内容区域，垂直布局
        Column({ space: 0 }) {
          HeaderSection()
            .padding({ top: 24 }) // 对应 Scaffold 的顶部内边距

          Row().height(32)

          BonsaiVisual()
            .width(220)
            .height(220) // 对应 Modifier.size(220.dp)

          Row().height(32)

          StatusRow()

          Row().height(32)

          ActivityLogSection()
            .padding({ bottom: 24 }) // 底部内边距，确保内容不会紧贴底部
        }
        .width('100%')
        // 对应 Column 的水平内边距(24) + 为底部导航栏预留空间(80.dp)
        .padding({ left: 24, right: 24, bottom: 80 })
        .backgroundColor(ZenColors.zenWhite) // 对应 Scaffold 的 containerColor
      }
      .width('100%')
      .height('100%')
      .backgroundColor(ZenColors.zenWhite) // 确保 Scroll 的背景色为白色

      // 底部导航栏
      SimpleBottomNav()
        .backgroundColor(ZenColors.zenWhite) // 底部导航栏背景色
        .expandSafeArea([SafeAreaType.KEYBOARD], [SafeAreaEdge.BOTTOM]) // 忽略键盘安全区域，防止键盘弹出时底部导航栏上移
    }
    .width('100%')
    .height('100%')
    .backgroundColor(ZenColors.zenWhite) // 整个应用的背景色
  }
}

// MARK: - HeaderSection
@Component
struct HeaderSection {
  build() {
    Column({ space: 0 }) {
      Text('JUNIPER · #04')
        .fontSize(AppTypography.labelMediumSize)
        .fontWeight(AppTypography.labelMediumWeight)
        .fontColor(ZenColors.zenTextSecondary)
        .letterSpacing(2) // 对应 letterSpacing = 2.sp
      Row().height(8) // 对应 Spacer(modifier = Modifier.height(8.dp))
      Text('Zen Garden')
        .fontSize(AppTypography.displaySmallLightSize)
        .fontWeight(AppTypography.displaySmallLightWeight)
        .fontColor(ZenColors.zenTextPrimary)
    }
  }
}

// MARK: - StatusRow
@Component
struct StatusRow {
  build() {
    // 使用 Row 结合 Blank 实现 SpaceEvenly 布局
    Row() {
      Blank() // 左侧 Spacer
      StatusItem({ icon: 'heart.fill', label: 'Health', value: '98%', tint: ZenColors.healthRed })
      Blank() // 元素间 Spacer
      StatusItem({ icon: 'calendar', label: 'Age', value: '4 Yrs', tint: ZenColors.zenBrown })
      Blank() // 元素间 Spacer
      StatusItem({ icon: 'checkmark.circle.fill', label: 'Water', value: '2 Days', tint: ZenColors.waterBlue })
      Blank() // 右侧 Spacer
    }
    .width('100%') // 对应 Modifier.fillMaxWidth()
  }
}

// MARK: - StatusItem
@Component
struct StatusItem {
  icon: string = ''; // SF Symbol 名称
  label: string = '';
  value: string = '';
  tint: string = '';

  build() {
    Column({ space: 0 }) {
      Stack() {
        Circle()
          .fill(ZenColors.statusItemBg)
          .stroke(ZenColors.statusItemBorder)
          .strokeWidth(1) // 对应 .border(1.dp, Color(0xFFECEFF1), CircleShape)
          .width(50)
          .height(50) // 对应 Modifier.size(50.dp)
        Text(this.icon) // SF Symbol 图标（ArkUI 无 SF Symbols，使用文本占位）
          .fontSize(20)
          .fontColor(this.tint)
          .textAlign(TextAlign.Center)
      }
      Row().height(8) // 对应 Spacer(modifier = Modifier.height(8.dp))
      Text(this.value)
        .fontSize(AppTypography.titleMediumBoldSize)
        .fontWeight(AppTypography.titleMediumBoldWeight)
        .fontColor(ZenColors.zenTextPrimary)
      Text(this.label)
        .fontSize(AppTypography.labelSmallSize)
        .fontWeight(AppTypography.labelSmallWeight)
        .fontColor(ZenColors.zenTextSecondary)
    }
  }
}

// MARK: - ActivityLogSection
@Component
struct ActivityLogSection {
  build() {
    Column({ space: 0 }) {
      Row() {
        Text('Care Schedule')
          .fontSize(AppTypography.titleMediumSemiBoldSize)
          .fontWeight(AppTypography.titleMediumSemiBoldWeight)
          .fontColor(ZenColors.zenTextPrimary)
        Blank() // 对应 horizontalArrangement = Arrangement.SpaceBetween
        Text('plus') // SF Symbol plus（ArkUI 无 SF Symbols，使用文本占位）
          .fontSize(20)
          .fontColor(ZenColors.zenGreen)
          .textAlign(TextAlign.Center)
          .width(28)
          .height(28) // 对应 Modifier.size(28.dp)；28.dp - 4.dp*2 = 20.dp icon size
          .backgroundColor(ZenColors.zenGreenLight) // 对应 .background(Color.zenGreenLight)
          .borderRadius(14) // 对应 CircleShape
          .onClick(() => {
            // Handle add log action
          })
      }
      .width('100%') // 对应 Modifier.fillMaxWidth()
      .alignItems(VerticalAlign.Center)

      Row().height(16) // 对应 Spacer(modifier = Modifier.height(16.dp))

      CareLogItem({ title: 'Watering', subtitle: 'Today, 8:00 AM', isDone: true })
      Row().height(12) // 对应 Spacer(modifier = Modifier.height(12.dp))
      CareLogItem({ title: 'Pruning', subtitle: 'Tomorrow', isDone: false })
      Row().height(12) // 对应 Spacer(modifier = Modifier.height(12.dp))
      CareLogItem({ title: 'Fertilizer', subtitle: 'In 5 days', isDone: false })
    }
    .width('100%') // 对应 Modifier.fillMaxWidth()
    .alignItems(HorizontalAlign.Start)
  }
}

// MARK: - CareLogItem
@Component
struct CareLogItem {
  title: string = '';
  subtitle: string = '';
  isDone: boolean = false;

  build() {
    Row({ space: 0 }) {
      Circle()
        .fill(this.isDone ? ZenColors.zenGreen : ZenColors.lightGrayCircle)
        .width(12)
        .height(12) // 对应 Modifier.size(12.dp)
      Row().width(16) // 对应 Spacer(modifier = Modifier.width(16.dp))
      Column({ space: 0 }) {
        Text(this.title)
          .fontSize(AppTypography.bodyMediumSize)
          .fontWeight(AppTypography.bodyMediumWeight)
          .fontColor(this.isDone ? ZenColors.zenTextPrimary : ZenColors.zenTextSecondary)
        Text(this.subtitle)
          .fontSize(AppTypography.labelSmallSize)
          .fontWeight(AppTypography.labelSmallWeight)
          .fontColor(ZenColors.careLogSubtitle)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1) // 对应 Modifier.weight(1f)
      if (this.isDone) {
        Text('checkmark') // SF Symbol checkmark（ArkUI 无 SF Symbols，使用文本占位）
          .fontSize(20)
          .fontColor(ZenColors.zenGreen)
          .textAlign(TextAlign.Center)
      }
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
    .padding(16) // 对应 .padding(16.dp)
    .backgroundColor(ZenColors.careLogBg)
    .borderRadius(12) // 对应 RoundedCornerShape(12.dp)
    .border({ width: 1, color: ZenColors.careLogBorder }) // 对应 .border(1.dp, Color(0xFFF0F0F0), RoundedCornerShape(12.dp))
  }
}

// MARK: - SimpleBottomNav
@Component
struct SimpleBottomNav {
  build() {
    Column({ space: 0 }) {
      // 底部导航栏上方的分割线
      Rect() // 使用 Rect 替代 Divider 以精确控制颜色和高度
        .fill(ZenColors.bottomBarDivider)
        .width('100%')
        .height(1) // 对应 border(width = 1.dp)
      Row({ space: 0 }) {
        // NavIcon 内部的 layoutWeight 会处理 SpaceAround 效果
        NavIcon({ icon: 'house.fill', isSelected: true })
        NavIcon({ icon: 'info.circle.fill', isSelected: false })
        NavIcon({ icon: 'gearshape.fill', isSelected: false })
      }
      .width('100%') // 对应 Modifier.fillMaxWidth()
      .height(80) // 对应 Modifier.height(80.dp)
      .backgroundColor(ZenColors.zenWhite) // 对应 .background(ZenWhite)
    }
    .width('100%')
  }
}

// MARK: - NavIcon
@Component
struct NavIcon {
  icon: string = ''; // SF Symbol 名称
  isSelected: boolean = false;

  build() {
    Column({ space: 0 }) {
      Text(this.icon) // SF Symbol 图标（ArkUI 无 SF Symbols，使用文本占位）
        .fontSize(24)
        .fontColor(this.isSelected ? ZenColors.zenGreen : ZenColors.navIconInactive)
        .textAlign(TextAlign.Center)
      if (this.isSelected) {
        Row().height(4) // 对应 Spacer(modifier = Modifier.height(4.dp))
        Circle()
          .fill(ZenColors.zenGreen)
          .width(4)
          .height(4) // 对应 Modifier.size(4.dp)
      }
    }
    .layoutWeight(1) // 使得每个图标占据等宽空间，实现 SpaceAround 效果
  }
}

// MARK: - Custom Art Logic (BonsaiVisual)
@Component
struct BonsaiVisual {
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  build() {
    // Canvas 视图用于自定义绘制
    Canvas(this.ctx)
      .width(220)
      .height(220)
      .onReady(() => {
        this.drawBonsai();
      })
  }

  private drawBonsai(): void {
    const w = 220;
    const h = 220;

    // 1. 绘制花盆
    const potWidth = w * 0.5;
    const potHeight = h * 0.15;
    const potTop = h * 0.85;

    this.ctx.fillStyle = ZenColors.zenBrown;
    this.ctx.fillRect((w - potWidth) / 2, potTop, potWidth, potHeight);
    // 花盆边缘
    this.ctx.globalAlpha = 0.8;
    this.ctx.fillRect((w - potWidth) / 2 - 10, potTop, potWidth + 20, 15);
    this.ctx.globalAlpha = 1.0;

    // 2. 绘制树干 (贝塞尔曲线)
    this.ctx.strokeStyle = ZenColors.trunkColor;
    this.ctx.lineWidth = 25;
    this.ctx.lineCap = 'round';
    this.ctx.beginPath();
    this.ctx.moveTo(w * 0.5, potTop); // 底部中心
    // 向上并向左弯曲
    this.ctx.quadraticCurveTo(w * 0.45, h * 0.6, w * 0.35, h * 0.5);
    // 向右弯曲
    this.ctx.quadraticCurveTo(w * 0.4, h * 0.35, w * 0.6, h * 0.3);
    this.ctx.stroke();

    // 次级树枝
    this.ctx.lineWidth = 15;
    this.ctx.beginPath();
    this.ctx.moveTo(w * 0.38, h * 0.55);
    this.ctx.lineTo(w * 0.25, h * 0.45);
    this.ctx.stroke();

    // 3. 绘制叶子 (圆形簇)
    // 叶簇 1 (右上)
    this.ctx.fillStyle = ZenColors.zenGreen;
    this.ctx.beginPath();
    this.ctx.ellipse(w * 0.6, h * 0.25, 45, 45, 0, 0, 2 * Math.PI);
    this.ctx.fill();
    this.ctx.globalAlpha = 0.8;
    this.ctx.beginPath();
    this.ctx.ellipse(w * 0.68, h * 0.28, 35, 35, 0, 0, 2 * Math.PI);
    this.ctx.fill();
    this.ctx.globalAlpha = 0.9;
    this.ctx.beginPath();
    this.ctx.ellipse(w * 0.55, h * 0.22, 30, 30, 0, 0, 2 * Math.PI);
    this.ctx.fill();
    this.ctx.globalAlpha = 1.0;

    // 叶簇 2 (中左)
    this.ctx.beginPath();
    this.ctx.ellipse(w * 0.35, h * 0.5, 35, 35, 0, 0, 2 * Math.PI);
    this.ctx.fill();
    this.ctx.globalAlpha = 0.8;
    this.ctx.beginPath();
    this.ctx.ellipse(w * 0.30, h * 0.45, 25, 25, 0, 0, 2 * Math.PI);
    this.ctx.fill();
    this.ctx.globalAlpha = 1.0;

    // 叶簇 3 (最左侧树枝)
    this.ctx.beginPath();
    this.ctx.ellipse(w * 0.22, h * 0.42, 25, 25, 0, 0, 2 * Math.PI);
    this.ctx.fill();
  }
}

// MARK: - Preview
// 提供预览功能，方便查看 UI 效果
@Preview
@Component
struct ZenBonsaiAppView_Previews {
  build() {
    ZenBonsaiAppView()
  }
}
