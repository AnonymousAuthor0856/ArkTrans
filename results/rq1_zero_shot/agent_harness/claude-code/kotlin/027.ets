@Entry
@Component
struct Index {
  @State selectedPage: number = 1
  @State selectedTool: string = "pen"
  private pages: number[] = Array.from({ length: 12 }, (_, i) => i + 1)

  build() {
    Column() {
      // Top App Bar
      Row() {
        // Navigation icon
        Circle({ width: 24, height: 24 })
          .fill(AppTokens.Colors.surfaceVariant)

        // Title
        Text("Document.pdf")
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        // Share button
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

      // Main content row
      Row() {
        // Left sidebar - page grid
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

        // Spacer
        Blank(12)

        // Main content area
        Stack({ alignContent: Alignment.CenterStart }) {
          // Page card
          Column() {
            Text(`Page ${this.selectedPage}`)
              .fontSize(24)
              .fontWeight(FontWeight.SemiBold)
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

          // Annotation toolbar
          Column({ space: 8 }) {
            AnnotationToolButton({
              icon: "P",
              toolName: "pen",
              selectedTool: this.selectedTool,
              onClick: () => { this.selectedTool = "pen" }
            })
            AnnotationToolButton({
              icon: "H",
              toolName: "highlighter",
              selectedTool: this.selectedTool,
              onClick: () => { this.selectedTool = "highlighter" }
            })
            AnnotationToolButton({
              icon: "T",
              toolName: "text",
              selectedTool: this.selectedTool,
              onClick: () => { this.selectedTool = "text" }
            })
            AnnotationToolButton({
              icon: "S",
              toolName: "shape",
              selectedTool: this.selectedTool,
              onClick: () => { this.selectedTool = "shape" }
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
  onClick: () => void = () => {}

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
      this.onClick()
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
