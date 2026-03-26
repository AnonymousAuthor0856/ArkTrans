package com.example.singlefileui

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Thermostat
import androidx.compose.material.icons.filled.WbSunny
import androidx.compose.material.icons.filled.WindPower
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.core.view.WindowCompat
import androidx.core.view.WindowInsetsCompat
import androidx.core.view.WindowInsetsControllerCompat

private const val NAME = "101_ThermoCurve_en"
private const val UI_TYPE = "SmartHome Form"
private const val STYLE_THEME = "Cold Gradient"
private const val LANG = "en"
private const val BASELINE_SIZE = "720x1280"

object AppTokens {
    object Colors {
        val primary = Color(0xFF3B82F6)
        val secondary = Color(0xFF06B6D4)
        val tertiary = Color(0xFF0EA5E9)
        val background = Color(0xFFF0F9FF)
        val surface = Color(0xFFFFFFFF)
        val surfaceVariant = Color(0xFFE0F2FE)
        val outline = Color(0xFFCBD5E1)
        val onPrimary = Color(0xFFFFFFFF)
        val onBackground = Color(0xFF0F172A)
        val onSurface = Color(0xFF1E293B)
    }
    object TypographyTokens {
        val display = TextStyle(fontSize = 26.sp, fontWeight = FontWeight.Bold)
        val headline = TextStyle(fontSize = 18.sp, fontWeight = FontWeight.SemiBold)
        val title = TextStyle(fontSize = 14.sp, fontWeight = FontWeight.Medium)
        val body = TextStyle(fontSize = 12.sp, fontWeight = FontWeight.Normal)
    }
    object Shapes {
        val small = RoundedCornerShape(8.dp)
        val medium = RoundedCornerShape(12.dp)
        val large = RoundedCornerShape(18.dp)
    }
    object Spacing {
        val sm = 8.dp
        val md = 12.dp
        val lg = 18.dp
        val xl = 26.dp
    }
}

private val AppColorScheme = lightColorScheme(
    primary = AppTokens.Colors.primary,
    onPrimary = AppTokens.Colors.onPrimary,
    secondary = AppTokens.Colors.secondary,
    onSecondary = AppTokens.Colors.onPrimary,
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

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun RootScreen() {
    var targetTemp by rememberSaveable { mutableIntStateOf(22) }
    var mode by rememberSaveable { mutableStateOf("Cool") }

    Scaffold(
        contentWindowInsets = WindowInsets(0),
        topBar = {
            CenterAlignedTopAppBar(
                title = { Text("ThermoCurve", style = MaterialTheme.typography.displayLarge) },
                navigationIcon = {
                    Icon(
                        Icons.Filled.Thermostat,
                        contentDescription = null,
                        tint = AppTokens.Colors.primary,
                        modifier = Modifier.padding(start = 12.dp)
                    )
                },
                actions = {
                    IconButton(onClick = { targetTemp++ }) {
                        Icon(
                            Icons.Filled.WbSunny,
                            contentDescription = "Heat Mode",
                            tint = AppTokens.Colors.secondary
                        )
                    }
                },
                colors = TopAppBarDefaults.centerAlignedTopAppBarColors(
                    containerColor = AppTokens.Colors.surfaceVariant
                )
            )
        },
        containerColor = AppTokens.Colors.background
    ) { padding ->
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(padding)
                .background(
                    Brush.verticalGradient(
                        listOf(AppTokens.Colors.secondary.copy(alpha = 0.15f), AppTokens.Colors.primary.copy(alpha = 0.2f))
                    )
                )
                .padding(AppTokens.Spacing.lg),
            verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.xl),
            horizontalAlignment = Alignment.CenterHorizontally
        ) {
            Text("Target Temperature", style = MaterialTheme.typography.headlineMedium, color = AppTokens.Colors.onSurface)
            Text(
                "$targetTemp°C",
                style = MaterialTheme.typography.displayLarge.copy(fontSize = 48.sp),
                color = AppTokens.Colors.primary
            )
            Row(
                horizontalArrangement = Arrangement.spacedBy(AppTokens.Spacing.md),
                verticalAlignment = Alignment.CenterVertically
            ) {
                Button(
                    onClick = { if (targetTemp > 10) targetTemp-- },
                    colors = ButtonDefaults.buttonColors(containerColor = AppTokens.Colors.primary)
                ) { Text("–", color = AppTokens.Colors.onPrimary, fontSize = 20.sp) }

                Button(
                    onClick = { if (targetTemp < 35) targetTemp++ },
                    colors = ButtonDefaults.buttonColors(containerColor = AppTokens.Colors.primary)
                ) { Text("+", color = AppTokens.Colors.onPrimary, fontSize = 20.sp) }
            }

            HorizontalDivider(
                color = AppTokens.Colors.outline.copy(alpha = 0.5f),
                thickness = 1.dp,
                modifier = Modifier.fillMaxWidth(0.8f)
            )

            Text("Mode", style = MaterialTheme.typography.headlineMedium, color = AppTokens.Colors.onSurface)
            Row(horizontalArrangement = Arrangement.spacedBy(AppTokens.Spacing.lg)) {
                ModeButton("Cool", Icons.Filled.WindPower, mode, onSelect = { mode = it })
                ModeButton("Heat", Icons.Filled.WbSunny, mode, onSelect = { mode = it })
            }

            Text("Current Mode: $mode", style = MaterialTheme.typography.bodyMedium, color = AppTokens.Colors.onSurface)
        }
    }
}

@Composable
fun ModeButton(label: String, icon: androidx.compose.ui.graphics.vector.ImageVector, current: String, onSelect: (String) -> Unit) {
    val isSelected = label == current
    ElevatedButton(
        onClick = { onSelect(label) },
        colors = ButtonDefaults.elevatedButtonColors(
            containerColor = if (isSelected) AppTokens.Colors.primary else AppTokens.Colors.surfaceVariant,
            contentColor = if (isSelected) AppTokens.Colors.onPrimary else AppTokens.Colors.onSurface
        ),
        shape = CircleShape,
        modifier = Modifier.size(100.dp)
    ) {
        Column(horizontalAlignment = Alignment.CenterHorizontally) {
            Icon(icon, contentDescription = label, modifier = Modifier.size(32.dp))
            Text(label)
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
            AppTheme { Surface(color = MaterialTheme.colorScheme.background) { RootScreen() } }
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

@Preview(showBackground = true, backgroundColor = 0xFFF0F9FF)
@Composable
fun PreviewRoot() {
    AppTheme { RootScreen() }
}
