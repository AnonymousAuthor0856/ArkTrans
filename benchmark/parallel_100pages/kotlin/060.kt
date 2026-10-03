package com.example.singlefileui

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.*
import androidx.compose.runtime.*
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

private const val NAME = "093_UnitConverter_en"
private const val UI_TYPE = "Tools Messenger"
private const val STYLE_THEME = "Modern Blue"
private const val LANG = "en"
private const val BASELINE_SIZE = "720x1280"

object AppTokens {
    object Colors {
        val primary = Color(0xFF2563EB)
        val secondary = Color(0xFF38BDF8)
        val tertiary = Color(0xFF60A5FA)
        val background = Color(0xFFF8FAFC)
        val surface = Color(0xFFFFFFFF)
        val surfaceVariant = Color(0xFFE2E8F0)
        val outline = Color(0xFFCBD5E1)
        val onPrimary = Color(0xFFFFFFFF)
        val onSecondary = Color(0xFF0F172A)
        val onTertiary = Color(0xFFFFFFFF)
        val onBackground = Color(0xFF0F172A)
        val onSurface = Color(0xFF1E293B)
    }
    object TypographyTokens {
        val display = TextStyle(fontSize = 24.sp, fontWeight = FontWeight.Bold)
        val headline = TextStyle(fontSize = 18.sp, fontWeight = FontWeight.SemiBold)
        val title = TextStyle(fontSize = 14.sp, fontWeight = FontWeight.Medium)
        val body = TextStyle(fontSize = 12.sp, fontWeight = FontWeight.Normal)
    }
    object Shapes {
        val small = RoundedCornerShape(6.dp)
        val medium = RoundedCornerShape(10.dp)
        val large = RoundedCornerShape(14.dp)
    }
    object Spacing {
        val sm = 6.dp
        val md = 10.dp
        val lg = 14.dp
        val xl = 20.dp
    }
}

private val AppColorScheme = lightColorScheme(
    primary = AppTokens.Colors.primary,
    onPrimary = AppTokens.Colors.onPrimary,
    secondary = AppTokens.Colors.secondary,
    onSecondary = AppTokens.Colors.onSecondary,
    background = AppTokens.Colors.background,
    onBackground = AppTokens.Colors.onBackground,
    surface = AppTokens.Colors.surface,
    onSurface = AppTokens.Colors.onSurface,
    surfaceVariant = AppTokens.Colors.surfaceVariant,
    outline = AppTokens.Colors.outline
)

private val AppTypography = Typography(
    displayLarge = AppTokens.TypographyTokens.display,
    headlineMedium = AppTokens.TypographyTokens.headline,
    titleMedium = AppTokens.TypographyTokens.title,
    bodyMedium = AppTokens.TypographyTokens.body
)

@Composable
fun AppTheme(content: @Composable () -> Unit) {
    MaterialTheme(
        colorScheme = AppColorScheme,
        typography = AppTypography,
        shapes = Shapes(
            small = AppTokens.Shapes.small,
            medium = AppTokens.Shapes.medium,
            large = AppTokens.Shapes.large
        ),
        content = content
    )
}

@Composable
fun MarkerBox(unit: String, value: String, active: Boolean) {
    Box(
        modifier = Modifier
            .fillMaxWidth()
            .height(80.dp)
            .background(
                if (active) AppTokens.Colors.secondary.copy(alpha = 0.3f)
                else AppTokens.Colors.surface,
                AppTokens.Shapes.medium
            )
            .border(1.dp, AppTokens.Colors.outline, AppTokens.Shapes.medium)
            .padding(AppTokens.Spacing.md),
        contentAlignment = Alignment.CenterStart
    ) {
        Column {
            Text(unit, style = MaterialTheme.typography.headlineMedium, color = AppTokens.Colors.onSurface)
            Text(value, style = MaterialTheme.typography.bodyMedium, color = AppTokens.Colors.onSurface)
        }
    }
}

@Composable
fun MapArea(selected: String) {
    Column(
        modifier = Modifier
            .fillMaxWidth()
            .height(240.dp)
            .background(AppTokens.Colors.surfaceVariant, AppTokens.Shapes.large)
            .border(1.dp, AppTokens.Colors.outline, AppTokens.Shapes.large)
            .padding(AppTokens.Spacing.lg),
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.Center
    ) {
        Text("Unit Map Visualization", style = MaterialTheme.typography.headlineMedium, color = AppTokens.Colors.onSurface)
        Spacer(Modifier.height(AppTokens.Spacing.md))
        Text("Active Unit: $selected", style = MaterialTheme.typography.bodyMedium, color = AppTokens.Colors.onSurface)
    }
}

@Composable
fun RootScreen() {
    val markers = listOf("Length", "Weight", "Temperature", "Speed")
    val active = remember { mutableStateOf(markers.first()) }

    Column(
        modifier = Modifier
            .fillMaxSize()
            .background(
                Brush.verticalGradient(
                    listOf(AppTokens.Colors.secondary.copy(alpha = 0.15f), AppTokens.Colors.primary.copy(alpha = 0.15f))
                )
            )
            .padding(AppTokens.Spacing.lg),
        verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.lg),
        horizontalAlignment = Alignment.CenterHorizontally
    ) {
        Text("Unit Converter", style = MaterialTheme.typography.displayLarge, color = AppTokens.Colors.onBackground)
        MapArea(selected = active.value)
        markers.forEach {
            MarkerBox(it, "Tap to convert", active = active.value == it)
        }
        Spacer(Modifier.height(AppTokens.Spacing.md))
        Row(horizontalArrangement = Arrangement.spacedBy(AppTokens.Spacing.md)) {
            markers.forEach {
                Button(
                    onClick = { active.value = it },
                    colors = ButtonDefaults.buttonColors(
                        containerColor = if (active.value == it) AppTokens.Colors.primary else AppTokens.Colors.surfaceVariant,
                        contentColor = if (active.value == it) AppTokens.Colors.onPrimary else AppTokens.Colors.onSurface
                    )
                ) {
                    Text(it, style = MaterialTheme.typography.titleMedium)
                }
            }
        }
    }
}

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        WindowCompat.setDecorFitsSystemWindows(window, false)
        val controller = WindowInsetsControllerCompat(window, window.decorView)
        controller.systemBarsBehavior = WindowInsetsControllerCompat.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
        controller.hide(WindowInsetsCompat.Type.navigationBars() or WindowInsetsCompat.Type.statusBars())
        setContent {
            AppTheme {
                Surface(color = MaterialTheme.colorScheme.background) { RootScreen() }
            }
        }
    }
    override fun onWindowFocusChanged(hasFocus: Boolean) {
        super.onWindowFocusChanged(hasFocus)
        if (hasFocus) {
            val controller = WindowInsetsControllerCompat(window, window.decorView)
            controller.systemBarsBehavior = WindowInsetsControllerCompat.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
            controller.hide(WindowInsetsCompat.Type.navigationBars() or WindowInsetsCompat.Type.statusBars())
        }
    }
}

@Preview(showBackground = true, backgroundColor = 0xFFF8FAFC)
@Composable
fun PreviewRoot() {
    AppTheme { RootScreen() }
}
