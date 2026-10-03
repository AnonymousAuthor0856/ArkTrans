// ArkTS 翻译自 SwiftUI 源文件 (098.swift)
// 茶叶冲泡指南应用 (ZenBrew / Mindful Steeping Guide)

// MARK: - Color Extension for Hex Initialization
// 方便地通过十六进制颜色值初始化颜色 (Swift 的 Color Extension 在 ArkTS 中以字符串常量实现)
const primaryBlack: string = '#FF121212'
const textGrey: string = '#FF757575'
const backgroundWhite: string = '#FFFFFF'
const cardBackground: string = '#FFF9F9F9'
const promoCardBackground: string = '#FFF0F0F0'
const lightGreyBorder: string = '#FFEEEEEE'
const veryLightGreyBorder: string = '#FFE0E0E0'
const grey: string = '#FF9E9E9E' // 对应 SwiftUI 的 Color.gray

// 将颜色 (格式 #AARRGGBB) 设置为指定透明度，对应 SwiftUI 的 .opacity()
function withAlpha(hexColor: string, alpha: number): string {
  const alphaInt: number = Math.round(alpha * 255)
  let alphaHex: string = alphaInt.toString(16)
  if (alphaHex.length === 1) {
    alphaHex = '0' + alphaHex
  }
  return '#' + alphaHex.toUpperCase() + hexColor.substring(3)
}

// MARK: - Data Models (纯 UI 模拟数据)
// TeaGuide 数据模型，添加 id 以用于 ForEach
class TeaGuide {
  id: number
  name: string
  origin: string
  temp: string
  time: string
  colorCode: string

  constructor(id: number, name: string, origin: string, temp: string, time: string, colorCode: string) {
    this.id = id
    this.name = name
    this.origin = origin
    this.temp = temp
    this.time = time
    this.colorCode = colorCode
  }
}

// 模拟茶叶数据，与 Kotlin 版本保持一致
const sampleTeas: TeaGuide[] = [
  new TeaGuide(1, 'Sencha Green', 'Japan', '70°C / 158°F', '1-2 min', '#FF8BC34A'),
  new TeaGuide(2, 'Earl Grey', 'Blend', '95°C / 203°F', '3-5 min', '#FF795548'),
  new TeaGuide(3, 'Silver Needle', 'China', '80°C / 176°F', '3-4 min', '#FFE0E0E0'),
  new TeaGuide(4, 'Darjeeling', 'India', '90°C / 194°F', '3 min', '#FFD7CCC8'),
  new TeaGuide(5, 'Chamomile', 'Egypt', '100°C / 212°F', '5-7 min', '#FFFFEB3B'),
  new TeaGuide(6, 'Matcha', 'Japan', '80°C / 176°F', 'Whisk', '#FF4CAF50'),
  new TeaGuide(7, 'Oolong', 'Taiwan', '85°C / 185°F', '3-5 min', '#FFFF9800')
]

// MARK: - UI Components

// 信息徽章视图，对应 Kotlin 的 InfoBadge Composable
@Component
struct InfoBadge {
  label: string = ''

  build() {
    Text(this.label)
      .fontSize(11) // fontSize = 11.sp
      .fontColor('#000000') // 对应 .foregroundColor(.black)
      .padding({ left: 6, right: 6, top: 2, bottom: 2 }) // 对应 modifier = Modifier.padding(horizontal = 6.dp, vertical = 2.dp)
      .backgroundColor('#FFFFFF') // 对应 color = Color.White
      .borderRadius(6) // 对应 shape = RoundedCornerShape(6.dp)
      .border({ width: 1, color: veryLightGreyBorder, radius: 6 }) // 对应 border = BorderStroke(1.dp, Color(0xFFE0E0E0))
  }
}

// 茶叶详情卡片视图，对应 Kotlin 的 TeaItemCard Composable
@Component
struct TeaItemCard {
  tea: TeaGuide = new TeaGuide(0, '', '', '', '', '#00000000')

  build() {
    Row() { // 对应 Row
      // 左侧圆形标识符
      Stack({ alignContent: Alignment.Center }) { // 对应 Box
        Circle({ width: 50, height: 50 }) // 对应 modifier = Modifier.size(50.dp)
          .fill('#FFFFFF') // 对应 background(Color.White)
          .stroke(withAlpha(this.tea.colorCode, 0.3)) // 对应 border(BorderStroke(2.dp, tea.colorCode.copy(alpha = 0.3f)), CircleShape)
          .strokeWidth(2)
        Text(this.tea.name.substring(0, 1)) // 对应 tea.name.take(1)
          .fontSize(20) // fontSize = 20.sp
          .fontWeight(700) // fontWeight = FontWeight.Bold
          .fontColor(this.tea.colorCode)
      }
      .clip(true) // 对应 .clip(CircleShape)

      Blank()
        .width(16) // 对应 Spacer(modifier = Modifier.width(16.dp))

      Column() { // 对应 Column
        Text(this.tea.name)
          .fontSize(17) // fontSize = 17.sp
          .fontWeight(700) // fontWeight = FontWeight.Bold
          .fontColor(primaryBlack)
        Text(this.tea.origin)
          .fontSize(12) // fontSize = 12.sp
          .fontColor(textGrey)
        Blank()
          .height(6) // 对应 Spacer(modifier = Modifier.height(6.dp))
        Row({ space: 8 }) { // 对应 Row
          InfoBadge({ label: this.tea.temp })
          InfoBadge({ label: this.tea.time })
        }
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1) // 对应 modifier = Modifier.weight(1f)

      // 右侧播放按钮
      Button() {
        Text('▶') // 对应 Icons.Default.PlayArrow
          .fontSize(20) // 对应 modifier = Modifier.size(20.dp)
          .fontColor(primaryBlack)
      }
      .width(40) // 对应 modifier = Modifier.size(40.dp)
      .height(40)
      .backgroundColor('#FFFFFF') // 对应 background(Color.White)
      .borderRadius(20) // 对应 CircleShape
      .border({ width: 1, color: veryLightGreyBorder, radius: 20 }) // 对应 border(1.dp, Color(0xFFE0E0E0), CircleShape)
      .onClick(() => {
        // 处理播放按钮点击
        console.log('Play for ' + this.tea.name + ' tapped')
      })
    }
    .padding(16) // 对应 modifier = Modifier.padding(16.dp)
    .backgroundColor(cardBackground) // 对应 colors = CardDefaults.cardColors(containerColor = bgColor)
    .borderRadius(16) // 对应 shape = RoundedCornerShape(16.dp)
    .border({ width: 1, color: lightGreyBorder, radius: 16 }) // 对应 border = BorderStroke(1.dp, Color(0xFFEEEEEE))
    // Kotlin 版本 elevation = 0.dp，ArkTS 中可省略 shadow 或设置为 radius: 0
  }
}

// 推广卡片视图，对应 Kotlin 的 PromoCard Composable
@Component
struct PromoCard {
  build() {
    Row() { // 对应 Row
      Column() { // 对应 Column
        Text('Tip of the day')
          .fontSize(12) // fontSize = 12.sp
          .fontWeight(700) // fontWeight = FontWeight.Bold
          .fontColor(grey) // 对应 .foregroundColor(.gray)
          .padding({ bottom: 4 }) // modifier = Modifier.padding(bottom = 4.dp)
        Text('Use filtered water for a purer taste profile.')
          .fontSize(16) // fontSize = 16.sp
          .fontWeight(500) // fontWeight = FontWeight.Medium
          .fontColor(primaryBlack)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1) // 对应 modifier = Modifier.weight(1f)

      Blank()
        .width(16) // 对应 Spacer(modifier = Modifier.width(16.dp))

      // 右侧圆形图标区域
      Stack({ alignContent: Alignment.Center }) { // 对应 Box(contentAlignment = Alignment.Center)
        Circle({ width: 48, height: 48 }) // 对应 modifier = Modifier.size(48.dp)
          .fill('#FFFFFF') // 对应 color = Color.White
        Text('ⓘ') // 对应 Icons.Default.Info
          .fontSize(24) // 图标大小
          .fontColor(grey) // 对应 .foregroundColor(.gray)
      }
    }
    .padding(24) // 对应 modifier = Modifier.padding(24.dp)
    .backgroundColor(promoCardBackground) // 对应 colors = CardDefaults.cardColors(containerColor = Color(0xFFF0F0F0))
    .borderRadius(20) // 对应 shape = RoundedCornerShape(20.dp)
    // Kotlin 版本 elevation = 0.dp，SwiftUI 中可省略 shadow 或设置为 radius: 0
  }
}

// 主应用视图，对应 Kotlin 的 ZenBrewApp Composable
@Entry
@Component
struct ZenBrewAppView {
  build() {
    // ZStack 用于分层布局，将浮动按钮置于内容之上
    Stack({ alignContent: Alignment.BottomEnd }) {
      // 主内容区域，可滚动
      Scroll() { // ScrollView(.vertical, showsIndicators: false)
        Column({ space: 16 }) { // 对应 Kotlin 的 verticalArrangement = Arrangement.spacedBy(16.dp)
          // 顶部栏 (模拟 TopAppBar)
          Row() {
            Column() {
              Text('ZenBrew')
                .fontSize(24) // fontSize = 24.sp
                .fontWeight(700) // fontWeight = FontWeight.Bold
                .fontColor(primaryBlack)
                .letterSpacing(-0.5) // letterSpacing = (-0.5).sp
              Text('Mindful Steeping Guide')
                .fontSize(14) // fontSize = 14.sp
                .fontWeight(400) // fontWeight = FontWeight.Normal
                .fontColor(textGrey)
            }
            .alignItems(HorizontalAlign.Start)

            Blank() // Spacer()

            Button() {
              Text('⚙') // 对应 Icons.Default.Settings
                .fontSize(24) // 默认图标大小
                .fontColor(primaryBlack)
            }
            .width(44) // 增大按钮点击区域，符合 iOS 规范
            .height(44)
            .backgroundColor(Color.Transparent)
            .onClick(() => {
              // 处理设置按钮点击
              console.log('Settings tapped')
            })
          }
          .width('100%')
          .padding({ left: 20, right: 20, top: 10 }) // 对应 LazyColumn 的 contentPadding horizontal 及顶部栏自身顶部内边距

          // 推广卡片
          PromoCard()
            .padding({ left: 20, right: 20 }) // 对应 LazyColumn 的 contentPadding horizontal

          // "Collections" 标题
          Text('Collections')
            .fontSize(18) // fontSize = 18.sp
            .fontWeight(600) // fontWeight = FontWeight.SemiBold
            .fontColor(primaryBlack)
            .width('100%') // 对应 modifier = Modifier.fillMaxWidth()
            .textAlign(TextAlign.Start)
            .padding({ top: 8, bottom: 8 }) // modifier = Modifier.padding(vertical = 8.dp)
            .padding({ left: 20, right: 20 }) // 对应 LazyColumn 的 contentPadding horizontal

          // 茶叶列表卡片
          ForEach(sampleTeas, (tea: TeaGuide) => {
            TeaItemCard({ tea: tea })
              .padding({ left: 20, right: 20 }) // 对应 LazyColumn 的 contentPadding horizontal
          }, (tea: TeaGuide) => tea.id.toString())

          // 浮动按钮的额外间距，防止内容被遮挡
          Blank()
            .height(80) // 对应 Spacer(modifier = Modifier.height(80.dp))
        }
        .width('100%')
        .padding({ top: 10, bottom: 10 }) // 对应 LazyColumn 的 contentPadding vertical
      }
      .width('100%')
      .height('100%')
      .scrollBar(BarState.Off)
      .backgroundColor(backgroundWhite) // 对应 Scaffold containerColor & background，且填充到屏幕边缘 (enableEdgeToEdge)

      // 浮动操作按钮 (FAB)
      Button() {
        Row({ space: 8 }) { // 对应 Spacer(modifier = Modifier.width(8.dp))
          Text('+') // 对应 Icons.Default.Add
            .fontSize(20) // 图标大小
            .fontColor('#FFFFFF')
          Text('Custom Brew')
            .fontSize(16) // 按钮文本大小
            .fontWeight(500)
            .fontColor('#FFFFFF') // 对应 contentColor = Color.White
        }
        .height(56) // 对应 modifier = Modifier.height(56.dp)
        .padding({ left: 24, right: 24 }) // 按钮内部水平填充
        .backgroundColor(primaryBlack) // 对应 containerColor = primaryBlack
        .borderRadius(16) // 对应 shape = RoundedCornerShape(16.dp)
      }
      .backgroundColor(Color.Transparent)
      .padding(0)
      .onClick(() => {
        // 处理自定义冲泡按钮点击
        console.log('Custom Brew tapped')
      })
      .margin({ right: 20, bottom: 20 }) // FAB 距离右侧/底部的内边距
    }
    .width('100%')
    .height('100%')
    .backgroundColor(backgroundWhite) // 确保整个背景是白色
    // 隐藏顶部状态栏，对应 WindowInsetsControllerCompat.hide(WindowInsetsCompat.Type.systemBars())
  }
}

// MARK: - App Entry Point
// ArkTS 使用 @Entry 装饰器标记页面入口 (已标注在 ZenBrewAppView 上)，
// 对应 SwiftUI 的 @main struct ZenBrewApp: App 以及 Kotlin 的 MainActivity。

// MARK: - Preview Section
// Xcode 预览区域，对应 Kotlin 的 @Preview (ArkTS 的 Previewer 由 DevEco Studio 提供)。
