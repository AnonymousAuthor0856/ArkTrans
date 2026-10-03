package com.example.singlefileui

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.WindowInsets
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.verticalScroll
import androidx.compose.foundation.rememberScrollState
import androidx.compose.material3.Button
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.CenterAlignedTopAppBar
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.FilterChip
import androidx.compose.material3.FilterChipDefaults
import androidx.compose.material3.LinearProgressIndicator
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Slider
import androidx.compose.material3.SliderDefaults
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.material3.TextButton
import androidx.compose.material3.TopAppBarDefaults
import androidx.compose.material3.lightColorScheme
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.core.view.WindowCompat
import androidx.core.view.WindowInsetsCompat
import androidx.core.view.WindowInsetsControllerCompat

private const val NAME = "205_SmartOrbitPanel_en"
private const val UI_TYPE = "SmartHome ControlPanel"
private const val STYLE_THEME = "Retro Flat"
private const val LANG = "en"
private const val BASELINE_SIZE = "720x1280"
private const val DENSITY_SPACING = "Compact"
private const val COMPLEXITY = "Includes Slider and ProgressBar to tune orbit lighting, monitor zones and provide flat retro meters."
private const val EXTRA = "Include all widgets listed in KeyWidgets at least once in the layout, use rounded corners between 12 dp and 20 dp, and rely only on shape or text placeholders instead of external images or custom fonts."

object AppTokens {
    object Colors {
        val primary = Color(0xFFD95F02)
        val secondary = Color(0xFF1B9AAA)
        val tertiary = Color(0xFFFEC601)
        val background = Color(0xFFF9F4EB)
        val surface = Color(0xFFFFFFFF)
        val surfaceVariant = Color(0xFFF0E3D1)
        val outline = Color(0xFFE1CDB2)
        val success = Color(0xFF56C271)
        val warning = Color(0xFFF4A259)
        val error = Color(0xFFD7263D)
        val onPrimary = Color(0xFF1B1B1B)
        val onSecondary = Color(0xFF041012)
        val onTertiary = Color(0xFF1E1200)
        val onBackground = Color(0xFF2C2A29)
        val onSurface = Color(0xFF2E2924)
    }
    object TypographyTokens {
        val display = TextStyle(fontSize = 28.sp, fontWeight = FontWeight.SemiBold, lineHeight = 34.sp, letterSpacing = 0.sp)
        val headline = TextStyle(fontSize = 20.sp, fontWeight = FontWeight.SemiBold, lineHeight = 28.sp, letterSpacing = 0.sp)
        val title = TextStyle(fontSize = 16.sp, fontWeight = FontWeight.Medium, lineHeight = 22.sp, letterSpacing = 0.sp)
        val body = TextStyle(fontSize = 13.sp, fontWeight = FontWeight.Normal, lineHeight = 18.sp, letterSpacing = 0.sp)
        val label = TextStyle(fontSize = 11.sp, fontWeight = FontWeight.Medium, lineHeight = 16.sp, letterSpacing = 0.sp)
    }
    object Shapes {
        val small = RoundedCornerShape(12.dp)
        val medium = RoundedCornerShape(16.dp)
        val large = RoundedCornerShape(20.dp)
    }
    object Spacing {
        val xs = 4.dp
        val sm = 8.dp
        val md = 12.dp
        val lg = 16.dp
        val xl = 20.dp
        val xxl = 28.dp
        val xxxl = 40.dp
    }
    data class ShadowSpec(val elevation: Dp, val radius: Dp, val dy: Dp, val opacity: Float)
    object ElevationMapping {
        val level1 = ShadowSpec(2.dp, 4.dp, 2.dp, 0.12f)
        val level2 = ShadowSpec(4.dp, 8.dp, 4.dp, 0.16f)
        val level3 = ShadowSpec(8.dp, 12.dp, 6.dp, 0.2f)
        val level4 = ShadowSpec(12.dp, 16.dp, 8.dp, 0.24f)
        val level5 = ShadowSpec(16.dp, 20.dp, 10.dp, 0.28f)
    }
}

private val AppColorScheme = lightColorScheme(
    primary = AppTokens.Colors.primary,
    onPrimary = AppTokens.Colors.onPrimary,
    secondary = AppTokens.Colors.secondary,
    onSecondary = AppTokens.Colors.onSecondary,
    tertiary = AppTokens.Colors.tertiary,
    onTertiary = AppTokens.Colors.onTertiary,
    background = AppTokens.Colors.background,
    onBackground = AppTokens.Colors.onBackground,
    surface = AppTokens.Colors.surface,
    onSurface = AppTokens.Colors.onSurface,
    surfaceVariant = AppTokens.Colors.surfaceVariant,
    outline = AppTokens.Colors.outline,
    error = AppTokens.Colors.error
)

private val AppTypography = androidx.compose.material3.Typography(
    displayLarge = AppTokens.TypographyTokens.display,
    headlineLarge = AppTokens.TypographyTokens.headline,
    titleLarge = AppTokens.TypographyTokens.title,
    bodyMedium = AppTokens.TypographyTokens.body,
    labelMedium = AppTokens.TypographyTokens.label
)

private val AppShapes = androidx.compose.material3.Shapes(
    small = AppTokens.Shapes.small,
    medium = AppTokens.Shapes.medium,
    large = AppTokens.Shapes.large
)

@Composable
fun AppTheme(content: @Composable () -> Unit) {
    MaterialTheme(colorScheme = AppColorScheme, typography = AppTypography, shapes = AppShapes, content = content)
}

data class Zone(val name: String, val humidity: Float, val temp: String)

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun RootScreen() {
    val spacing = AppTokens.Spacing
    val modes = listOf("Orbit", "Eclipse", "Manual")
    var activeMode by remember { mutableStateOf(modes.first()) }
    var solarLevel by remember { mutableStateOf(0.6f) }
    var ambientGlow by remember { mutableStateOf(0.35f) }
    val zones = listOf(
        Zone("Atrium", 0.45f, "72°F"),
        Zone("Lab East", 0.62f, "68°F"),
        Zone("Hab Deck", 0.30f, "70°F")
    )
    Scaffold(
        modifier = Modifier.fillMaxSize(),
        containerColor = AppTokens.Colors.background,
        contentWindowInsets = WindowInsets(0),
        topBar = {
            CenterAlignedTopAppBar(
                title = { Text(text = "Smart Orbit Panel", style = AppTokens.TypographyTokens.title, color = AppTokens.Colors.onSurface) },
                navigationIcon = {
                    TextButton(onClick = {}) {
                        Text(text = "Dock", style = AppTokens.TypographyTokens.label, color = AppTokens.Colors.onSurface)
                    }
                },
                actions = {
                    TextButton(onClick = {}) {
                        Text(text = "Alerts", style = AppTokens.TypographyTokens.label, color = AppTokens.Colors.secondary)
                    }
                },
                colors = TopAppBarDefaults.centerAlignedTopAppBarColors(containerColor = AppTokens.Colors.surface)
            )
        },
        bottomBar = {
            Surface(color = AppTokens.Colors.surface, tonalElevation = AppTokens.ElevationMapping.level2.elevation, shadowElevation = AppTokens.ElevationMapping.level2.elevation) {
                Row(
                    modifier = Modifier
                        .fillMaxWidth()
                        .padding(horizontal = spacing.lg, vertical = spacing.sm),
                    horizontalArrangement = Arrangement.SpaceBetween,
                    verticalAlignment = Alignment.CenterVertically
                ) {
                    Column(verticalArrangement = Arrangement.spacedBy(spacing.xs)) {
                        Text(text = "Grid draw", style = AppTokens.TypographyTokens.label, color = AppTokens.Colors.onSurface)
                        Text(text = "18.4 kWh", style = AppTokens.TypographyTokens.title, color = AppTokens.Colors.primary)
                    }
                    Button(onClick = {}, shape = AppTokens.Shapes.medium) {
                        Text(text = "Engage eco hold", style = AppTokens.TypographyTokens.label)
                    }
                }
            }
        }
    ) { paddingValues ->
        Column(
            modifier = Modifier
                .padding(paddingValues)
                .verticalScroll(rememberScrollState())
                .padding(horizontal = spacing.lg, vertical = spacing.sm),
            verticalArrangement = Arrangement.spacedBy(spacing.md)
        ) {
            Row(horizontalArrangement = Arrangement.spacedBy(spacing.sm), modifier = Modifier.fillMaxWidth()) {
                modes.forEach { mode ->
                    FilterChip(
                        selected = activeMode == mode,
                        onClick = { activeMode = mode },
                        label = { Text(text = mode, style = AppTokens.TypographyTokens.label) },
                        colors = FilterChipDefaults.filterChipColors(
                            containerColor = AppTokens.Colors.surface,
                            selectedContainerColor = AppTokens.Colors.primary.copy(alpha = 0.15f),
                            labelColor = AppTokens.Colors.onSurface,
                            selectedLabelColor = AppTokens.Colors.onSurface
                        ),
                        shape = AppTokens.Shapes.small
                    )
                }
            }
            Card(
                shape = AppTokens.Shapes.large,
                colors = CardDefaults.cardColors(containerColor = AppTokens.Colors.surface)
            ) {
                Column(modifier = Modifier.padding(spacing.lg), verticalArrangement = Arrangement.spacedBy(spacing.sm)) {
                    Text(text = "Solar wash", style = AppTokens.TypographyTokens.headline, color = AppTokens.Colors.onSurface)
                    Text(text = "Adjust orbital window glow", style = AppTokens.TypographyTokens.body, color = AppTokens.Colors.onSurface.copy(alpha = 0.7f))
                    Slider(
                        value = solarLevel,
                        onValueChange = { solarLevel = it },
                        colors = SliderDefaults.colors(thumbColor = AppTokens.Colors.primary, activeTrackColor = AppTokens.Colors.primary)
                    )
                    Row(horizontalArrangement = Arrangement.SpaceBetween, modifier = Modifier.fillMaxWidth()) {
                        Text(text = "0%", style = AppTokens.TypographyTokens.label, color = AppTokens.Colors.onSurface)
                        Text(text = "${(solarLevel * 100).toInt()}%", style = AppTokens.TypographyTokens.title, color = AppTokens.Colors.primary)
                    }
                    Text(text = "Ambient glow", style = AppTokens.TypographyTokens.headline, color = AppTokens.Colors.onSurface)
                    Slider(
                        value = ambientGlow,
                        onValueChange = { ambientGlow = it },
                        colors = SliderDefaults.colors(thumbColor = AppTokens.Colors.secondary, activeTrackColor = AppTokens.Colors.secondary)
                    )
                    LinearProgressIndicator(
                        progress = ambientGlow,
                        color = AppTokens.Colors.secondary,
                        trackColor = AppTokens.Colors.surfaceVariant,
                        modifier = Modifier.fillMaxWidth()
                    )
                }
            }
            Card(
                shape = AppTokens.Shapes.large,
                colors = CardDefaults.cardColors(containerColor = AppTokens.Colors.surfaceVariant)
            ) {
                Column(modifier = Modifier.padding(spacing.lg), verticalArrangement = Arrangement.spacedBy(spacing.sm)) {
                    Text(text = "Orbit health", style = AppTokens.TypographyTokens.headline, color = AppTokens.Colors.onSurface)
                    StatusRow(label = "Atmos mix", value = 0.74f, accent = AppTokens.Colors.secondary)
                    StatusRow(label = "Hull temp", value = 0.42f, accent = AppTokens.Colors.primary)
                    StatusRow(label = "Shield sync", value = 0.88f, accent = AppTokens.Colors.tertiary)
                }
            }
            Card(
                shape = AppTokens.Shapes.large,
                colors = CardDefaults.cardColors(containerColor = AppTokens.Colors.surface)
            ) {
                Column(modifier = Modifier.padding(spacing.lg), verticalArrangement = Arrangement.spacedBy(spacing.sm)) {
                    Text(text = "Deck zones", style = AppTokens.TypographyTokens.headline, color = AppTokens.Colors.onSurface)
                    zones.forEach { zone ->
                        ZoneRow(zone)
                    }
                }
            }
        }
    }
}

@Composable
fun StatusRow(label: String, value: Float, accent: Color) {
    Column(verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.xs)) {
        Row(horizontalArrangement = Arrangement.SpaceBetween, modifier = Modifier.fillMaxWidth()) {
            Text(text = label, style = AppTokens.TypographyTokens.body, color = AppTokens.Colors.onSurface)
            Text(text = "${(value * 100).toInt()}%", style = AppTokens.TypographyTokens.label, color = accent)
        }
        LinearProgressIndicator(
            progress = value,
            color = accent,
            trackColor = AppTokens.Colors.surface,
            modifier = Modifier.fillMaxWidth()
        )
    }
}

@Composable
fun ZoneRow(zone: Zone) {
    Column(modifier = Modifier.background(AppTokens.Colors.surfaceVariant.copy(alpha = 0.5f), AppTokens.Shapes.small).padding(AppTokens.Spacing.sm), verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.xs)) {
        Row(horizontalArrangement = Arrangement.SpaceBetween, modifier = Modifier.fillMaxWidth()) {
            Text(text = zone.name, style = AppTokens.TypographyTokens.title, color = AppTokens.Colors.onSurface)
            Text(text = zone.temp, style = AppTokens.TypographyTokens.label, color = AppTokens.Colors.primary)
        }
        LinearProgressIndicator(
            progress = zone.humidity,
            color = AppTokens.Colors.secondary,
            trackColor = AppTokens.Colors.surface,
            modifier = Modifier.fillMaxWidth()
        )
    }
}

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        WindowCompat.setDecorFitsSystemWindows(window, false)
        val controller = WindowInsetsControllerCompat(window, window.decorView)
        controller.systemBarsBehavior = WindowInsetsControllerCompat.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
        controller.hide(WindowInsetsCompat.Type.systemBars())
        setContent {
            AppTheme {
                Surface(color = MaterialTheme.colorScheme.background) {
                    RootScreen()
                }
            }
        }
    }

    override fun onWindowFocusChanged(hasFocus: Boolean) {
        super.onWindowFocusChanged(hasFocus)
        if (hasFocus) {
            WindowInsetsControllerCompat(window, window.decorView).hide(WindowInsetsCompat.Type.systemBars())
        }
    }
}

@Preview(showBackground = true)
@Composable
fun PreviewRoot() {
    AppTheme {
        Surface(color = MaterialTheme.colorScheme.background) {
            RootScreen()
        }
    }
}