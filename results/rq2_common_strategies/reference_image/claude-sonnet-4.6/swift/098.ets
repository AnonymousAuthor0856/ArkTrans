/*
 * ZenBrew — HarmonyOS ArkTS (ArkUI) 版本
 * 由 SwiftUI 版本 1:1 转换而来
 */

// ---------------- 主题颜色 (ARGB) ----------------
const COLOR_PRIMARY_BLACK: string = '#FF121212';
const COLOR_TEXT_GREY: string = '#FF757575';
const COLOR_BACKGROUND_WHITE: string = '#FFFFFFFF';
const COLOR_CARD_BACKGROUND: string = '#FFF9F9F9';
const COLOR_PROMO_CARD_BACKGROUND: string = '#FFF0F0F0';
const COLOR_LIGHT_GREY_BORDER: string = '#FFEEEEEE';
const COLOR_VERY_LIGHT_GREY_BORDER: string = '#FFE0E0E0';
const COLOR_MID_GREY: string = '#FF9E9E9E';

// ---------------- 数据模型 ----------------
class TeaGuide {
  id: number;
  name: string;
  origin: string;
  temp: string;
  time: string;
  colorCode: string;

  constructor(id: number, name: string, origin: string,
              temp: string, time: string, colorCode: string) {
    this.id = id;
    this.name = name;
    this.origin = origin;
    this.temp = temp;
    this.time = time;
    this.colorCode = colorCode;
  }

  /** 取名称首字母，对应 SwiftUI 的 name.prefix(1) */
  initial(): string {
    return this.name.length > 0 ? this.name.substring(0, 1) : '';
  }

  /** 颜色的 30% 透明度版本，用于圆形描边 */
  glowColor(): string {
    // colorCode 形如 '#FF8BC34A' -> '#4D8BC34A'
    return '#4D' + this.colorCode.substring(3);
  }
}

const SAMPLE_TEAS: TeaGuide[] = [
  new TeaGuide(1, 'Sencha Green', 'Japan', '70°C / 158°F', '1-2 min', '#FF8BC34A'),
  new TeaGuide(2, 'Earl Grey', 'Blend', '95°C / 203°F', '3-5 min', '#FF795548'),
  new TeaGuide(3, 'Silver Needle', 'China', '80°C / 176°F', '3-4 min', '#FFE0E0E0'),
  new TeaGuide(4, 'Darjeeling', 'India', '90°C / 194°F', '3 min', '#FFD7CCC8'),
  new TeaGuide(5, 'Chamomile', 'Egypt', '100°C / 212°F', '5-7 min', '#FFFFEB3B'),
  new TeaGuide(6, 'Matcha', 'Japan', '80°C / 176°F', 'Whisk', '#FF4CAF50'),
  new TeaGuide(7, 'Oolong', 'Taiwan', '85°C / 185°F', '3-5 min', '#FFFF9800')
];

// ---------------- 信息徽章 ----------------
@Component
struct InfoBadge {
  label: string = '';

  build() {
    Text(this.label)
      .fontSize(11)
      .fontColor(Color.Black)
      .padding({ left: 6, right: 6, top: 2, bottom: 2 })
      .backgroundColor(Color.White)
      .borderRadius(6)
      .border({ width: 1, color: COLOR_VERY_LIGHT_GREY_BORDER })
  }
}

// ---------------- 每日提示卡片 ----------------
@Component
struct PromoCard {
  build() {
    Row() {
      Column({ space: 4 }) {
        Text('Tip of the day')
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor(COLOR_MID_GREY)

        Text('Use filtered water for a purer taste profile.')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLOR_PRIMARY_BLACK)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      // 右侧圆形信息图标
      Stack() {
        Stack() {
          Text('i')
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.White)
        }
        .width(24)
        .height(24)
        .borderRadius(12)
        .backgroundColor(COLOR_MID_GREY)
      }
      .width(48)
      .height(48)
      .borderRadius(24)
      .backgroundColor(Color.White)
      .margin({ left: 16 })
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
    .padding(24)
    .backgroundColor(COLOR_PROMO_CARD_BACKGROUND)
    .borderRadius(20)
  }
}

// ---------------- 茶叶条目卡片 ----------------
@Component
struct TeaItemCard {
  tea: TeaGuide = SAMPLE_TEAS[0];

  build() {
    Row() {
      // 左侧字母圆标
      Stack() {
        Text(this.tea.initial())
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.tea.colorCode)
      }
      .width(50)
      .height(50)
      .borderRadius(25)
      .backgroundColor(Color.White)
      .border({ width: 2, color: this.tea.glowColor() })

      // 中间信息区
      Column({ space: 2 }) {
        Text(this.tea.name)
          .fontSize(17)
          .fontWeight(FontWeight.Bold)
          .fontColor(COLOR_PRIMARY_BLACK)

        Text(this.tea.origin)
          .fontSize(12)
          .fontColor(COLOR_TEXT_GREY)

        Row({ space: 8 }) {
          InfoBadge({ label: this.tea.temp })
          InfoBadge({ label: this.tea.time })
        }
        .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
      .margin({ left: 16 })

      // 右侧播放按钮
      Stack() {
        Text('▶')
          .fontSize(14)
          .fontColor(COLOR_PRIMARY_BLACK)
      }
      .width(40)
      .height(40)
      .borderRadius(20)
      .backgroundColor(Color.White)
      .border({ width: 1, color: COLOR_VERY_LIGHT_GREY_BORDER })
      .onClick(() => {
        console.info(`Play for ${this.tea.name} tapped`);
      })
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
    .padding(16)
    .backgroundColor(COLOR_CARD_BACKGROUND)
    .borderRadius(16)
    .border({ width: 1, color: COLOR_LIGHT_GREY_BORDER })
  }
}

// ---------------- 主页面 ----------------
@Entry
@Component
struct ZenBrewApp {
  private teas: TeaGuide[] = SAMPLE_TEAS;

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Scroll() {
        Column({ space: 16 }) {
          // 顶部栏
          Row() {
            Column({ space: 2 }) {
              Text('ZenBrew')
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor(COLOR_PRIMARY_BLACK)
                .letterSpacing(-0.5)

              Text('Mindful Steeping Guide')
                .fontSize(14)
                .fontColor(COLOR_TEXT_GREY)
            }
            .alignItems(HorizontalAlign.Start)
            .layoutWeight(1)

            Stack() {
              Text('⚙')
                .fontSize(22)
                .fontColor(COLOR_PRIMARY_BLACK)
            }
            .width(44)
            .height(44)
            .onClick(() => {
              console.info('Settings tapped');
            })
          }
          .width('100%')
          .alignItems(VerticalAlign.Top)
          .padding({ left: 20, right: 20, top: 10 })

          // 推广卡片
          Column() {
            PromoCard()
          }
          .width('100%')
          .padding({ left: 20, right: 20 })

          // 分区标题
          Text('Collections')
            .fontSize(18)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(COLOR_PRIMARY_BLACK)
            .width('100%')
            .textAlign(TextAlign.Start)
            .padding({ left: 20, right: 20, top: 8, bottom: 8 })

          // 茶叶列表
          ForEach(this.teas, (tea: TeaGuide) => {
            Column() {
              TeaItemCard({ tea: tea })
            }
            .width('100%')
            .padding({ left: 20, right: 20 })
          }, (tea: TeaGuide) => tea.id.toString())

          // 底部留白，避免被浮动按钮遮挡
          Column() {
          }
          .width('100%')
          .height(80)
        }
        .width('100%')
        .padding({ top: 10, bottom: 10 })
      }
      .width('100%')
      .height('100%')
      .scrollBar(BarState.Off)
      .align(Alignment.TopStart)

      // 浮动操作按钮 (FAB)
      Row({ space: 8 }) {
        Text('+')
          .fontSize(24)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.White)

        Text('Custom Brew')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.White)
      }
      .height(56)
      .padding({ left: 24, right: 24 })
      .backgroundColor(COLOR_PRIMARY_BLACK)
      .borderRadius(16)
      .margin({ right: 20, bottom: 20 })
      .onClick(() => {
        console.info('Custom Brew tapped');
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLOR_BACKGROUND_WHITE)
  }
}