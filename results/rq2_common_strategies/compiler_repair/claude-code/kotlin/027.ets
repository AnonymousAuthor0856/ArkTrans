@Entry
@Component
struct Index {
  @State selectedPage: number = 1
  @State selectedTool: string = "pen"
  private pages: number[] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]

  build() {
    Column() {
      Row() {
        Circle({ width: 24, height: 24 })
          .fill(AppTokens.Colors.surfaceVariant)

        Text("Document.pdf")
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Button("Share")
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onPrimary)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(20)
          .height(36)
          .padding({ left: 16, right: 16 })
      }
      .width("100%")
      .height(56)
      .padding({ left: 16, right: 16 })
      .backgroundColor(AppTokens.Colors.background)

      Row() {
        Grid() {
          ForEach(this.pages, (page: number) => {
            GridItem() {
              Column() {
                Text(page.toString())
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(this.selectedPage === page ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
              }
              .width("100%")
              .height("100%")
              .justifyContent(FlexAlign.Center)
              .backgroundColor(this.selectedPage === page ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
              .borderRadius(8)
              .border({
                width: this.selectedPage === page ? 2 : 0,
                color: AppTokens.Colors.primary
              })
              .aspectRatio(0.7)
              .onClick(() => {
                this.selectedPage = page
              })
            }
          }, (page: number) => page.toString())
        }
        .columnsTemplate("1fr 1fr")
        .rowsGap(8)
        .columnsGap(8)
        .width(150)
        .height("100%")
        .padding(8)

        Blank(12)

        Stack({ alignContent: Alignment.Start }) {
          Column() {
            Text("Page " + this.selectedPage)
              .fontSize(24)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.onSurface)
          }
          .width("100%")
          .height("100%")
          .justifyContent(FlexAlign.Center)
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(12)
          .shadow({
            radius: 2,
            color: "rgba(0,0,0,0.08)",
            offsetY: 1
          })

          Column({ space: 8 }) {
            AnnotationToolButton({
              icon: "P",
              toolName: "pen",
              selectedTool: this.selectedTool,
              onTap: () => { this.selectedTool = "pen" }
            })
            AnnotationToolButton({
              icon: "H",
              toolName: "highlighter",
              selectedTool: this.selectedTool,
              onTap: () => { this.selectedTool = "highlighter" }
            })
            AnnotationToolButton({
              icon: "T",
              toolName: "text",
              selectedTool: this.selectedTool,
              onTap: () => { this.selectedTool = "text" }
            })
            AnnotationToolButton({
              icon: "S",
              toolName: "shape",
              selectedTool: this.selectedTool,
              onTap: () => { this.selectedTool = "shape" }
            })
          }
          .padding(8)
          .margin({ left: 12 })
          .backgroundColor("rgba(255,255,255,0.8)")
          .borderRadius(12)
          .border({ width: 1, color: AppTokens.Colors.outline })
        }
        .layoutWeight(1)
        .height("100%")
      }
      .width("100%")
      .layoutWeight(1)
      .padding(12)
      .backgroundColor(AppTokens.Colors.background)
    }
    .width("100%")
    .height("100%")
    .backgroundColor(AppTokens.Colors.background)
  }
}

@Component
struct AnnotationToolButton {
  icon: string = ""
  toolName: string = ""
  selectedTool: string = ""
  onTap: () => void = () => {}

  build() {
    Column() {
      Text(this.icon)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.toolName === this.selectedTool ? AppTokens.Colors.onSecondary : AppTokens.Colors.onSurface)
    }
    .width(40)
    .height(40)
    .justifyContent(FlexAlign.Center)
    .borderRadius(20)
    .backgroundColor(this.toolName === this.selectedTool ? AppTokens.Colors.secondary : AppTokens.Colors.surfaceVariant)
    .onClick(() => {
      this.onTap()
    })
  }
}

namespace AppTokens {
  export namespace Colors {
    export const primary: string = "#FFA0C4FF"
    export const secondary: string = "#FFB7E4C7"
    export const tertiary: string = "#FFFFDDC1"
    export const background: string = "#FFF8F7FF"
    export const surface: string = "#FFFFFFFF"
    export const surfaceVariant: string = "#FFF0F0F5"
    export const outline: string = "#FFD9D9E3"
    export const success: string = "#FFB4E4C7"
    export const warning: string = "#FFFFDDC1"
    export const error: string = "#FFFFB4AB"
    export const onPrimary: string = "#FF001D3D"
    export const onSecondary: string = "#FF003720"
    export const onTertiary: string = "#FF3E2800"
    export const onBackground: string = "#FF1B1B1F"
    export const onSurface: string = "#FF1B1B1F"
  }

  export namespace Spacing {
    export const xs: number = 4
    export const sm: number = 8
    export const md: number = 12
    export const lg: number = 16
    export const xl: number = 24
  }
}
