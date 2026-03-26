package com.example.singlefileui

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.WindowInsets
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.CenterAlignedTopAppBar
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.IconButton
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Shapes
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.material3.TopAppBarDefaults
import androidx.compose.material3.Typography
import androidx.compose.material3.lightColorScheme
import androidx.compose.runtime.Composable
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Brush
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

private const val NAME = "128*MacroTrainer*en"
private const val UI_TYPE = "Workout"
private const val STYLE_THEME = "Dark Neon"
private const val LANG = "en"
private const val BASELINE_SIZE = "720x1280"
private const val COLOR_PALETTE = "primary:#7C4DFF secondary:#08D6FF tertiary:#FF8E3C background:#05030A surface:#0D0616 surfaceVariant:#1A0F2C outline:#3A2759 success:#56F0A6 warning:#FFC857 error:#FF5B7A onPrimary:#05030A onSecondary:#05030A onTertiary:#120601 onBackground:#F4ECFF onSurface:#F8F4FF"
private const val DENSITY_SPACING = "Compact"
private const val COMPLEXITY = "Timer,ProgressRing,CTA"
private const val EXTRA = "Neon macro workout controller"

object DesignTokens {
    object Colors {
        val primary = Color(0xFF7C4DFF)
        val secondary = Color(0xFF08D6FF)
        val tertiary = Color(0xFFFF8E3C)
        val background = Color(0xFF05030A)
        val surface = Color(0xFF0D0616)
        val surfaceVariant = Color(0xFF1A0F2C)
        val outline = Color(0xFF3A2759)
        val success = Color(0xFF56F0A6)
        val warning = Color(0xFFFFC857)
        val error = Color(0xFFFF5B7A)
        val onPrimary = Color(0xFF05030A)
        val onSecondary = Color(0xFF05030A)
        val onTertiary = Color(0xFF120601)
        val onBackground = Color(0xFFF4ECFF)
        val onSurface = Color(0xFFF8F4FF)
    }
    object TypographyTokens {
        val display = TextStyle(fontSize = 32.sp, fontWeight = FontWeight.Bold, lineHeight = 38.sp, letterSpacing = 0.sp)
        val headline = TextStyle(fontSize = 22.sp, fontWeight = FontWeight.SemiBold, lineHeight = 28.sp, letterSpacing = 0.1.sp)
        val title = TextStyle(fontSize = 16.sp, fontWeight = FontWeight.Medium, lineHeight = 22.sp, letterSpacing = 0.2.sp)
        val body = TextStyle(fontSize = 14.sp, fontWeight = FontWeight.Normal, lineHeight = 20.sp, letterSpacing = 0.2.sp)
        val label = TextStyle(fontSize = 12.sp, fontWeight = FontWeight.Medium, lineHeight = 16.sp, letterSpacing = 0.3.sp)
    }
    object Shapes {
        val small = RoundedCornerShape(8.dp)
        val medium = RoundedCornerShape(18.dp)
        val large = RoundedCornerShape(28.dp)
    }
    object Spacing {
        val xxs = 4.dp
        val xs = 8.dp
        val sm = 12.dp
        val md = 16.dp
        val lg = 20.dp
        val xl = 28.dp
        val xxl = 40.dp
        val xxxl = 56.dp
    }
    data class ShadowSpec(val elevation: Dp, val radius: Dp, val dy: Dp, val opacity: Float)
    object ElevationMapping {
        val level1 = ShadowSpec(2.dp, 4.dp, 2.dp, 0.18f)
        val level2 = ShadowSpec(6.dp, 8.dp, 4.dp, 0.22f)
        val level3 = ShadowSpec(12.dp, 12.dp, 6.dp, 0.26f)
        val level4 = ShadowSpec(18.dp, 18.dp, 8.dp, 0.3f)
        val level5 = ShadowSpec(24.dp, 24.dp, 10.dp, 0.34f)
    }
}

private val AppColorScheme = lightColorScheme(
    primary = DesignTokens.Colors.primary,
    onPrimary = DesignTokens.Colors.onPrimary,
    secondary = DesignTokens.Colors.secondary,
    onSecondary = DesignTokens.Colors.onSecondary,
    tertiary = DesignTokens.Colors.tertiary,
    onTertiary = DesignTokens.Colors.onTertiary,
    background = DesignTokens.Colors.background,
    onBackground = DesignTokens.Colors.onBackground,
    surface = DesignTokens.Colors.surface,
    onSurface = DesignTokens.Colors.onSurface,
    surfaceVariant = DesignTokens.Colors.surfaceVariant,
    outline = DesignTokens.Colors.outline,
    error = DesignTokens.Colors.error
)

private val AppTypography = Typography(
    displayLarge = DesignTokens.TypographyTokens.display,
    headlineMedium = DesignTokens.TypographyTokens.headline,
    titleMedium = DesignTokens.TypographyTokens.title,
    bodyMedium = DesignTokens.TypographyTokens.body,
    labelMedium = DesignTokens.TypographyTokens.label
)

@Composable
fun AppTheme(content: @Composable () -> Unit) {
    MaterialTheme(
        colorScheme = AppColorScheme,
        typography = AppTypography,
        shapes = Shapes(
            extraSmall = DesignTokens.Shapes.small,
            small = DesignTokens.Shapes.small,
            medium = DesignTokens.Shapes.medium,
            large = DesignTokens.Shapes.large,
            extraLarge = DesignTokens.Shapes.large
        ),
        content = content
    )
}

data class MacroSet(val title: String, val reps: String, val phase: String)

data class PerformanceMetric(val label: String, val value: String, val change: String)

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        WindowCompat.setDecorFitsSystemWindows(window, false)
        val controller = WindowInsetsControllerCompat(window, window.decorView)
        controller.systemBarsBehavior = WindowInsetsControllerCompat.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
        controller.hide(WindowInsetsCompat.Type.systemBars())
        setContent {
            AppTheme {
                RootScreen()
            }
        }
    }

    override fun onWindowFocusChanged(hasFocus: Boolean) {
        super.onWindowFocusChanged(hasFocus)
        if (hasFocus) {
            val controller = WindowInsetsControllerCompat(window, window.decorView)
            controller.systemBarsBehavior = WindowInsetsControllerCompat.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
            controller.hide(WindowInsetsCompat.Type.systemBars())
        }
    }
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun RootScreen() {
    val sets = listOf(
        MacroSet("Warm circuit", "3 sets", "Energy"),
        MacroSet("Core push", "4 rounds", "Explosive"),
        MacroSet("Cooldown flow", "6 min", "Calm")
    )
    val metrics = listOf(
        PerformanceMetric("Load", "72%", "+4%"),
        PerformanceMetric("VO2", "41", "+1"),
        PerformanceMetric("Focus", "88%", "stable")
    )
    val timerValue = remember { mutableStateOf("02:34") }
    val targetPhase = remember { mutableStateOf("Macro tempo") }
    Scaffold(
        contentWindowInsets = WindowInsets(0),
        containerColor = MaterialTheme.colorScheme.background,
        topBar = {
            CenterAlignedTopAppBar(
                colors = TopAppBarDefaults.centerAlignedTopAppBarColors(containerColor = MaterialTheme.colorScheme.surface.copy(alpha = 0.95f)),
                title = {
                    Column(horizontalAlignment = Alignment.CenterHorizontally) {
                        Text(text = "MacroTrainer", style = MaterialTheme.typography.titleMedium, color = MaterialTheme.colorScheme.onSurface)
                        Text(text = "Neon workout stack", style = MaterialTheme.typography.labelMedium, color = MaterialTheme.colorScheme.onSurface.copy(alpha = 0.7f))
                    }
                },
                navigationIcon = {
                    IconButton(onClick = {}) {
                        Box(modifier = Modifier.size(24.dp).background(MaterialTheme.colorScheme.surfaceVariant, CircleShape))
                    }
                },
                actions = {
                    IconButton(onClick = {}) {
                        Box(modifier = Modifier.size(24.dp).background(MaterialTheme.colorScheme.surfaceVariant, CircleShape))
                    }
                }
            )
        },
        bottomBar = {
            Surface(
                color = MaterialTheme.colorScheme.surfaceVariant,
                tonalElevation = DesignTokens.ElevationMapping.level3.elevation,
                shadowElevation = DesignTokens.ElevationMapping.level3.elevation
            ) {
                Row(
                    modifier = Modifier
                        .fillMaxWidth()
                        .padding(horizontal = DesignTokens.Spacing.lg, vertical = DesignTokens.Spacing.md),
                    horizontalArrangement = Arrangement.SpaceBetween,
                    verticalAlignment = Alignment.CenterVertically
                ) {
                    Column(verticalArrangement = Arrangement.spacedBy(DesignTokens.Spacing.xxs)) {
                        Text(text = "Next macro", style = MaterialTheme.typography.labelMedium, color = MaterialTheme.colorScheme.onSurface)
                        Text(text = targetPhase.value, style = MaterialTheme.typography.titleMedium, color = MaterialTheme.colorScheme.onSurface)
                    }
                    Button(
                        onClick = {},
                        shape = DesignTokens.Shapes.medium,
                        colors = ButtonDefaults.buttonColors(containerColor = MaterialTheme.colorScheme.secondary),
                        contentPadding = PaddingValues(horizontal = DesignTokens.Spacing.xl, vertical = DesignTokens.Spacing.xs)
                    ) {
                        Text(text = "Prime", style = MaterialTheme.typography.titleMedium, color = MaterialTheme.colorScheme.onSecondary)
                    }
                }
            }
        }
    ) { padding ->
        LazyColumn(
            modifier = Modifier
                .fillMaxSize()
                .padding(padding)
                .padding(horizontal = DesignTokens.Spacing.lg, vertical = DesignTokens.Spacing.md),
            verticalArrangement = Arrangement.spacedBy(DesignTokens.Spacing.lg)
        ) {
            item {
                Row(horizontalArrangement = Arrangement.spacedBy(DesignTokens.Spacing.sm), modifier = Modifier.fillMaxWidth()) {
                    Surface(
                        modifier = Modifier.weight(1f),
                        shape = DesignTokens.Shapes.large,
                        color = MaterialTheme.colorScheme.surface,
                        tonalElevation = DesignTokens.ElevationMapping.level2.elevation
                    ) {
                        Column(
                            modifier = Modifier.padding(DesignTokens.Spacing.md),
                            verticalArrangement = Arrangement.spacedBy(DesignTokens.Spacing.sm),
                            horizontalAlignment = Alignment.CenterHorizontally
                        ) {
                            Box(
                                modifier = Modifier
                                    .size(160.dp)
                                    .border(10.dp, Brush.sweepGradient(listOf(MaterialTheme.colorScheme.primary, MaterialTheme.colorScheme.secondary, MaterialTheme.colorScheme.tertiary, MaterialTheme.colorScheme.primary)), CircleShape)
                                    .background(MaterialTheme.colorScheme.surface, CircleShape),
                                contentAlignment = Alignment.Center
                            ) {
                                Column(horizontalAlignment = Alignment.CenterHorizontally) {
                                    Text(text = timerValue.value, style = MaterialTheme.typography.displayLarge, color = MaterialTheme.colorScheme.onSurface)
                                    Text(text = "Timer", style = MaterialTheme.typography.labelMedium, color = MaterialTheme.colorScheme.onSurface.copy(alpha = 0.7f))
                                }
                            }
                            Row(horizontalArrangement = Arrangement.spacedBy(DesignTokens.Spacing.xxs)) {
                                listOf("Macro", "Tempo", "Breath").forEach { tag ->
                                    Box(
                                        modifier = Modifier
                                            .background(MaterialTheme.colorScheme.surfaceVariant, DesignTokens.Shapes.small)
                                            .padding(horizontal = DesignTokens.Spacing.xs, vertical = DesignTokens.Spacing.xxs)
                                    ) {
                                        Text(text = tag, style = MaterialTheme.typography.labelMedium, color = MaterialTheme.colorScheme.onSurface)
                                    }
                                }
                            }
                        }
                    }
                    Column(
                        modifier = Modifier.width(120.dp),
                        verticalArrangement = Arrangement.spacedBy(DesignTokens.Spacing.sm)
                    ) {
                        metrics.forEach { metric ->
                            Column(
                                modifier = Modifier
                                    .fillMaxWidth()
                                    .background(MaterialTheme.colorScheme.surfaceVariant, DesignTokens.Shapes.medium)
                                    .padding(DesignTokens.Spacing.sm),
                                verticalArrangement = Arrangement.spacedBy(DesignTokens.Spacing.xxs)
                            ) {
                                Text(text = metric.label, style = MaterialTheme.typography.labelMedium, color = MaterialTheme.colorScheme.onSurface)
                                Text(text = metric.value, style = MaterialTheme.typography.headlineMedium, color = MaterialTheme.colorScheme.secondary)
                                Text(text = metric.change, style = MaterialTheme.typography.bodyMedium, color = MaterialTheme.colorScheme.onSurface.copy(alpha = 0.7f))
                            }
                        }
                    }
                }
            }
            items(sets) { set ->
                Row(
                    modifier = Modifier
                        .fillMaxWidth()
                        .background(MaterialTheme.colorScheme.surfaceVariant.copy(alpha = 0.9f), DesignTokens.Shapes.medium)
                        .padding(DesignTokens.Spacing.md),
                    horizontalArrangement = Arrangement.SpaceBetween,
                    verticalAlignment = Alignment.CenterVertically
                ) {
                    Column(verticalArrangement = Arrangement.spacedBy(DesignTokens.Spacing.xxs)) {
                        Text(text = set.title, style = MaterialTheme.typography.titleMedium, color = MaterialTheme.colorScheme.onSurface)
                        Text(text = set.phase, style = MaterialTheme.typography.bodyMedium, color = MaterialTheme.colorScheme.onSurface.copy(alpha = 0.7f))
                    }
                    Column(horizontalAlignment = Alignment.End, verticalArrangement = Arrangement.spacedBy(DesignTokens.Spacing.xxs)) {
                        Text(text = set.reps, style = MaterialTheme.typography.headlineMedium, color = MaterialTheme.colorScheme.primary)
                        Button(
                            onClick = {},
                            shape = DesignTokens.Shapes.small,
                            colors = ButtonDefaults.buttonColors(containerColor = MaterialTheme.colorScheme.secondary),
                            contentPadding = PaddingValues(horizontal = DesignTokens.Spacing.xs, vertical = DesignTokens.Spacing.xxs)
                        ) {
                            Text(text = "Start", style = MaterialTheme.typography.labelMedium, color = MaterialTheme.colorScheme.onSecondary)
                        }
                    }
                }
            }
        }
    }
}

@Preview(showBackground = true)
@Composable
fun PreviewRoot() {
    AppTheme {
        RootScreen()
    }
}