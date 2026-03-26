package com.example.singlefileui

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.AlertDialog
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.CenterAlignedTopAppBar
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.SegmentedButton
import androidx.compose.material3.SegmentedButtonDefaults
import androidx.compose.material3.SingleChoiceSegmentedButtonRow
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Shapes
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.material3.TextField
import androidx.compose.material3.TextFieldDefaults
import androidx.compose.material3.Typography
import androidx.compose.material3.lightColorScheme
import androidx.compose.runtime.Composable
import androidx.compose.runtime.mutableIntStateOf
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

private const val NAME = "065FlightCheckinen"
private const val UI_TYPE = "Travel"
private const val STYLE_THEME = "Modern Blue"
private const val LANG = "en"
private const val BASELINE_SIZE = "720x1280"

object AppTokens {
    object Colors {
        val primary = Color(0xFF1E3A8A)
        val secondary = Color(0xFF2563EB)
        val tertiary = Color(0xFF60A5FA)
        val background = Color(0xFFF5F8FF)
        val surface = Color(0xFFFFFFFF)
        val surfaceVariant = Color(0xFFE8EEFA)
        val outline = Color(0xFFCBD5E1)
        val success = Color(0xFF16A34A)
        val warning = Color(0xFFF59E0B)
        val error = Color(0xFFEF4444)
        val onPrimary = Color(0xFFFFFFFF)
        val onSecondary = Color(0xFFFFFFFF)
        val onTertiary = Color(0xFF0B1220)
        val onBackground = Color(0xFF0B1220)
        val onSurface = Color(0xFF0B1220)
    }
    object TypographyTokens {
        val display = TextStyle(fontSize = 28.sp, fontWeight = FontWeight.Bold)
        val headline = TextStyle(fontSize = 20.sp, fontWeight = FontWeight.SemiBold)
        val title = TextStyle(fontSize = 16.sp, fontWeight = FontWeight.Medium)
        val body = TextStyle(fontSize = 14.sp, fontWeight = FontWeight.Normal)
        val label = TextStyle(fontSize = 12.sp, fontWeight = FontWeight.Medium)
    }
    object Shapes {
        val small = RoundedCornerShape(8.dp)
        val medium = RoundedCornerShape(12.dp)
        val large = RoundedCornerShape(18.dp)
    }
    object Spacing {
        val xs = 6.dp
        val sm = 10.dp
        val md = 14.dp
        val lg = 18.dp
        val xl = 26.dp
        val xxl = 36.dp
    }
    data class ShadowSpec(val elevation: Dp, val radius: Dp, val dy: Dp, val opacity: Float)
    object ElevationMapping {
        val level1 = ShadowSpec(2.dp, 4.dp, 2.dp, 0.12f)
        val level2 = ShadowSpec(6.dp, 8.dp, 4.dp, 0.16f)
        val level3 = ShadowSpec(10.dp, 12.dp, 6.dp, 0.18f)
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

private val AppTypography = Typography(
    displayLarge = AppTokens.TypographyTokens.display,
    headlineMedium = AppTokens.TypographyTokens.headline,
    titleMedium = AppTokens.TypographyTokens.title,
    bodyMedium = AppTokens.TypographyTokens.body,
    labelMedium = AppTokens.TypographyTokens.label
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
    val name = remember { mutableStateOf("") }
    val code = remember { mutableStateOf("") }
    val seatTabs = listOf("Economy", "Premium", "Business")
    val selectedSeat = remember { mutableIntStateOf(0) }
    val showDialog = remember { mutableStateOf(false) }
    Scaffold(
        contentWindowInsets = androidx.compose.foundation.layout.WindowInsets(0),
        topBar = {
            CenterAlignedTopAppBar(
                title = { Text("Flight Check-in", style = MaterialTheme.typography.displayLarge, color = MaterialTheme.colorScheme.onSurface) },
                navigationIcon = {
                    Box(modifier = Modifier.padding(start = AppTokens.Spacing.lg).size(22.dp).background(MaterialTheme.colorScheme.primary, CircleShape))
                },
                actions = {
                    Box(modifier = Modifier.padding(end = AppTokens.Spacing.lg).size(22.dp).background(MaterialTheme.colorScheme.secondary, CircleShape))
                }
            )
        },
        containerColor = Color.Transparent
    ) { pad ->
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(pad)
                .background(
                    Brush.verticalGradient(
                        listOf(
                            AppTokens.Colors.tertiary.copy(alpha = 0.25f),
                            AppTokens.Colors.background,
                            AppTokens.Colors.secondary.copy(alpha = 0.2f)
                        )
                    )
                )
                .padding(horizontal = AppTokens.Spacing.lg, vertical = AppTokens.Spacing.md),
            verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.lg)
        ) {
            Card(
                shape = AppTokens.Shapes.large,
                colors = CardDefaults.cardColors(containerColor = AppTokens.Colors.surface),
                elevation = CardDefaults.cardElevation(AppTokens.ElevationMapping.level2.elevation),
                modifier = Modifier.fillMaxWidth()
            ) {
                Column(
                    modifier = Modifier.fillMaxWidth().padding(AppTokens.Spacing.lg),
                    verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.md)
                ) {
                    Text("Passenger", style = MaterialTheme.typography.headlineMedium, color = MaterialTheme.colorScheme.onSurface)
                    TextField(
                        value = name.value,
                        onValueChange = { name.value = it },
                        modifier = Modifier.fillMaxWidth(),
                        placeholder = { Text("Full name", color = AppTokens.Colors.onSurface.copy(alpha = 0.5f)) },
                        colors = TextFieldDefaults.colors(
                            focusedContainerColor = AppTokens.Colors.surfaceVariant,
                            unfocusedContainerColor = AppTokens.Colors.surfaceVariant,
                            focusedIndicatorColor = AppTokens.Colors.primary,
                            unfocusedIndicatorColor = AppTokens.Colors.outline
                        ),
                        shape = AppTokens.Shapes.medium
                    )
                    Text("Booking Code", style = MaterialTheme.typography.headlineMedium, color = MaterialTheme.colorScheme.onSurface)
                    TextField(
                        value = code.value,
                        onValueChange = { code.value = it },
                        modifier = Modifier.fillMaxWidth(),
                        placeholder = { Text("e.g. XY7ZK2", color = AppTokens.Colors.onSurface.copy(alpha = 0.5f)) },
                        colors = TextFieldDefaults.colors(
                            focusedContainerColor = AppTokens.Colors.surfaceVariant,
                            unfocusedContainerColor = AppTokens.Colors.surfaceVariant,
                            focusedIndicatorColor = AppTokens.Colors.primary,
                            unfocusedIndicatorColor = AppTokens.Colors.outline
                        ),
                        shape = AppTokens.Shapes.medium
                    )
                    Text("Seat Class", style = MaterialTheme.typography.headlineMedium, color = MaterialTheme.colorScheme.onSurface)
                    SingleChoiceSegmentedButtonRow {
                        seatTabs.forEachIndexed { index, label ->
                            SegmentedButton(
                                selected = selectedSeat.intValue == index,
                                onClick = { selectedSeat.intValue = index },
                                shape = SegmentedButtonDefaults.itemShape(index, seatTabs.size),
                                colors = SegmentedButtonDefaults.colors(
                                    activeContainerColor = AppTokens.Colors.primary,
                                    activeContentColor = AppTokens.Colors.onPrimary,
                                    inactiveContainerColor = AppTokens.Colors.surfaceVariant,
                                    inactiveContentColor = AppTokens.Colors.onSurface
                                )
                            ) {
                                Text(label, style = AppTokens.TypographyTokens.label)
                            }
                        }
                    }
                }
            }
            Card(
                shape = AppTokens.Shapes.large,
                colors = CardDefaults.cardColors(containerColor = AppTokens.Colors.surface),
                elevation = CardDefaults.cardElevation(AppTokens.ElevationMapping.level2.elevation),
                modifier = Modifier.fillMaxWidth()
            ) {
                Column(
                    modifier = Modifier.fillMaxWidth().padding(AppTokens.Spacing.lg),
                    verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.md)
                ) {
                    Row(
                        modifier = Modifier.fillMaxWidth(),
                        horizontalArrangement = Arrangement.SpaceBetween,
                        verticalAlignment = Alignment.CenterVertically
                    ) {
                        Column(verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.xs)) {
                            Text("Flight", style = AppTokens.TypographyTokens.title, color = AppTokens.Colors.onSurface)
                            Text("BL 213 • HND → CTS", style = AppTokens.TypographyTokens.body, color = AppTokens.Colors.onSurface)
                        }
                        Box(modifier = Modifier.size(36.dp).background(AppTokens.Colors.secondary, CircleShape))
                    }
                    Row(
                        modifier = Modifier.fillMaxWidth(),
                        horizontalArrangement = Arrangement.SpaceBetween,
                        verticalAlignment = Alignment.CenterVertically
                    ) {
                        Column {
                            Text("Boarding", style = AppTokens.TypographyTokens.label, color = AppTokens.Colors.onSurface)
                            Text("12:35", style = AppTokens.TypographyTokens.title, color = AppTokens.Colors.primary)
                        }
                        Column {
                            Text("Gate", style = AppTokens.TypographyTokens.label, color = AppTokens.Colors.onSurface)
                            Text("A12", style = AppTokens.TypographyTokens.title, color = AppTokens.Colors.primary)
                        }
                        Column {
                            Text("Seat", style = AppTokens.TypographyTokens.label, color = AppTokens.Colors.onSurface)
                            Text(if (selectedSeat.intValue == 0) "23C" else if (selectedSeat.intValue == 1) "11A" else "2F", style = AppTokens.TypographyTokens.title, color = AppTokens.Colors.primary)
                        }
                    }
                    Button(
                        onClick = { showDialog.value = true },
                        colors = ButtonDefaults.buttonColors(containerColor = AppTokens.Colors.primary, contentColor = AppTokens.Colors.onPrimary),
                        shape = AppTokens.Shapes.large,
                        modifier = Modifier.fillMaxWidth().height(52.dp)
                    ) {
                        Text("Confirm Check-in", style = AppTokens.TypographyTokens.title)
                    }
                }
            }
        }
    }
    if (showDialog.value) {
        AlertDialog(
            onDismissRequest = { showDialog.value = false },
            title = { Text("Check-in Successful", style = AppTokens.TypographyTokens.title, color = AppTokens.Colors.onSurface) },
            text = { Text("Boarding pass is ready. Have a nice flight.", style = AppTokens.TypographyTokens.body, color = AppTokens.Colors.onSurface) },
            confirmButton = {
                Button(
                    onClick = { showDialog.value = false },
                    colors = ButtonDefaults.buttonColors(containerColor = AppTokens.Colors.secondary, contentColor = AppTokens.Colors.onSecondary),
                    shape = AppTokens.Shapes.medium
                ) { Text("Done", style = AppTokens.TypographyTokens.label) }
            }
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
            val controller = WindowInsetsControllerCompat(window, window.decorView)
            controller.systemBarsBehavior = WindowInsetsControllerCompat.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
            controller.hide(WindowInsetsCompat.Type.systemBars())
        }
    }
}

@Preview(showBackground = true, backgroundColor = 0xFFF5F8FF)
@Composable
fun PreviewRoot() {
    AppTheme {
        RootScreen()
    }
}