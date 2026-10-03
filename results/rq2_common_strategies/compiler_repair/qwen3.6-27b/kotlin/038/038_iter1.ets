import {
  Button,
  Switch,
  Text,
  Row,
  Column,
  Stack,
  Box,
  Canvas,
  Surface,
  TopAppBar,
  Scaffold,
  MaterialTheme,
  lightColorScheme,
  Typography,
  Shapes,
  Spacing,
  ElevationMapping,
  AppTokens,
  Marker,
  RootScreen,
  PreviewScreen,
} from './components';

interface MarkerData {
  x: number;
  y: number;
  label: string;
}

@Entry
@Component
struct Index {
  @State scanning: boolean = false;
  @State markers: MarkerData[] = [
    { x: 120, y: 200, label: 'A1' },
    { x: 300, y: 400, label: 'B2' },
    { x: 520, y: 600, label: 'C3' },
  ];

  addMarker() {
    if (this.scanning) {
      const newMarker: MarkerData = {
        x: Math.floor(Math.random() * 500) + 80,
        y: Math.floor(Math.random() * 500) + 150,
        label: `N${this.markers.length + 1}`,
      };
      this.markers.push(newMarker);
    }
  }

  build() {
    MaterialTheme({
      colorScheme: lightColorScheme()
    }) {
      Scaffold({
        topBar: () => {
          TopAppBar({
            title: "Invoice Scanner"
          }).backgroundColor(AppTokens.Colors.background)
           .foregroundColor(AppTokens.Colors.onSurface)
        },
        containerColor: AppTokens.Colors.background
      }) {
        Column() {
          .width('100%')
          .height('100%')
          .padding(AppTokens.Spacing.lg)
          .linearGradient({
            direction: GradientDirection.BOTTOM,
            colors: [
              [AppTokens.Colors.secondary, 0.2],
              [AppTokens.Colors.background, 0.5],
              [AppTokens.Colors.primary, 0.2]
            ]
          })
          .alignItems(HorizontalAlign.Center)
          .justifyContent(FlexAlign.SpaceBetween)

          Surface({
            shape: AppTokens.Shapes.large,
            color: AppTokens.Colors.surface,
            shadowElevation: AppTokens.ElevationMapping.level2.elevation
          }) {
            Box() {
              .width('100%')
              .height(400)
              .borderRadius(AppTokens.Shapes.large.borderRadius)
              .justifyContent(FlexAlign.Center)
              .alignItems(HorizontalAlign.Center)

              Canvas() {
                .width('100%')
                .height('100%')
                .padding(AppTokens.Spacing.md)
                .onDraw((canvas: CanvasRenderingContext2D, ctx: CanvasRenderingContext2D) => {
                  const center = {
                    x: canvas.width / 2,
                    y: canvas.height / 2,
                  };
                  ctx.beginPath();
                  ctx.arc(
                    center.x,
                    center.y,
                    Math.min(canvas.width, canvas.height) / 2.5,
                    0,
                    2 * Math.PI
                  );
                  ctx.fillStyle = AppTokens.Colors.surfaceVariant;
                  ctx.fill();

                  this.markers.forEach((marker: MarkerData) => {
                    ctx.beginPath();
                    ctx.arc(marker.x, marker.y, 12, 0, 2 * Math.PI);
                    ctx.fillStyle = AppTokens.Colors.primary;
                    ctx.fill();
                  });
                })
              }
            }
          }

          Row() {
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)

            Text("Scanning Active")
              .fontSize(AppTokens.TypographyTokens.title.fontSize)
              .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
              .foregroundColor(AppTokens.Colors.onSurface)

            Switch({
              checked: this.scanning,
              onChange: (checked: boolean) => {
                this.scanning = checked;
              },
              colors: {
                checkedThumbColor: AppTokens.Colors.secondary,
                uncheckedThumbColor: AppTokens.Colors.outline,
              }
            })
          }

          Button({
            type: ButtonType.Capsule,
            stateEffect: true
          }) {
            Text("Add Marker")
              .fontSize(AppTokens.TypographyTokens.title.fontSize)
              .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
              .foregroundColor(AppTokens.Colors.onPrimary)
          }
          .onClick(() => this.addMarker())
          .shape(AppTokens.Shapes.medium)
          .backgroundColor(AppTokens.Colors.primary)
          .width('100%')
          .height(48)
          .borderRadius(AppTokens.Shapes.medium.borderRadius)
        }
      }
    }
  }
}