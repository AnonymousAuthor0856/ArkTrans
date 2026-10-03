import {
  Component,
  State,
  hmr,
  customStyle,
  buildCustomStyle,
} from '@kitui/core';
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

// Define the main application component
@Component({
  name: 'App',
})
export class App extends Component {
  // State for scanning toggle
  @State() scanning: boolean = false;

  // State for markers list
  @State() markers: Marker[] = [
    { x: 120, y: 200, label: 'A1' },
    { x: 300, y: 400, label: 'B2' },
    { x: 520, y: 600, label: 'C3' },
  ];

  // Method to add a new marker
  addMarker() {
    if (this.scanning) {
      const newMarker: Marker = {
        x: Math.floor(Math.random() * 500) + 80,
        y: Math.floor(Math.random() * 500) + 150,
        label: `N${this.markers.length + 1}`,
      };
      this.markers.push(newMarker);
    }
  }

  // Render method
  render() {
    return (
      <MaterialTheme>
        <Scaffold
          topBar={
            <TopAppBar
              title="Invoice Scanner"
              style={{
                backgroundColor: AppTokens.Colors.background,
                color: AppTokens.Colors.onSurface,
              }}
            />
          }
          containerColor={AppTokens.Colors.background}
        >
          <Column
            style={{
              flex: 1,
              padding: AppTokens.Spacing.lg,
              background: `linear-gradient(to bottom, ${AppTokens.Colors.secondary}33, ${AppTokens.Colors.background}, ${AppTokens.Colors.primary}33)`,
              alignItems: 'center',
              justifyContent: 'space-between',
            }}
          >
            <Surface
              shape={AppTokens.Shapes.large}
              color={AppTokens.Colors.surface}
              shadowElevation={AppTokens.ElevationMapping.level2.elevation}
              style={{
                width: '100%',
                height: 400,
                borderRadius: AppTokens.Shapes.large.borderRadius,
              }}
            >
              <Box
                style={{
                  flex: 1,
                  justifyContent: 'center',
                  alignItems: 'center',
                }}
              >
                <Canvas
                  style={{
                    width: '100%',
                    height: '100%',
                    padding: AppTokens.Spacing.md,
                  }}
                  onDraw={(ctx) => {
                    const center = {
                      x: ctx.canvas.width / 2,
                      y: ctx.canvas.height / 2,
                    };
                    ctx.beginPath();
                    ctx.arc(
                      center.x,
                      center.y,
                      Math.min(ctx.canvas.width, ctx.canvas.height) / 2.5,
                      0,
                      2 * Math.PI
                    );
                    ctx.fillStyle = AppTokens.Colors.surfaceVariant;
                    ctx.fill();

                    this.markers.forEach((marker) => {
                      ctx.beginPath();
                      ctx.arc(marker.x, marker.y, 12, 0, 2 * Math.PI);
                      ctx.fillStyle = AppTokens.Colors.primary;
                      ctx.fill();
                    });
                  }}
                />
              </Box>
            </Surface>

            <Row
              style={{
                width: '100%',
                justifyContent: 'space-between',
                alignItems: 'center',
              }}
            >
              <Text
                style={{
                  fontSize: AppTokens.TypographyTokens.title.fontSize,
                  fontWeight: AppTokens.TypographyTokens.title.fontWeight,
                  color: AppTokens.Colors.onSurface,
                }}
              >
                Scanning Active
              </Text>
              <Switch
                checked={this.scanning}
                onCheckedChange={(checked) => {
                  this.scanning = checked;
                }}
                colors={{
                  checkedThumbColor: AppTokens.Colors.secondary,
                  uncheckedThumbColor: AppTokens.Colors.outline,
                }}
              />
            </Row>

            <Button
              onClick={() => this.addMarker()}
              shape={AppTokens.Shapes.medium}
              colors={{
                containerColor: AppTokens.Colors.primary,
                contentColor: AppTokens.Colors.onPrimary,
              }}
              style={{
                width: '100%',
                height: 48,
                borderRadius: AppTokens.Shapes.medium.borderRadius,
              }}
            >
              <Text
                style={{
                  fontSize: AppTokens.TypographyTokens.title.fontSize,
                  fontWeight: AppTokens.TypographyTokens.title.fontWeight,
                  color: AppTokens.Colors.onPrimary,
                }}
              >
                Add Marker
              </Text>
            </Button>
          </Column>
        </Scaffold>
      </MaterialTheme>
    );
  }
}

// Export the preview screen for development tools
export default PreviewScreen;