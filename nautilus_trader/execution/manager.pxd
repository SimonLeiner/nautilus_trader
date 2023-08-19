# -------------------------------------------------------------------------------------------------
#  Copyright (C) 2015-2023 Nautech Systems Pty Ltd. All rights reserved.
#  https://nautechsystems.io
#
#  Licensed under the GNU Lesser General Public License Version 3.0 (the "License");
#  You may not use this file except in compliance with the License.
#  You may obtain a copy of the License at https://www.gnu.org/licenses/lgpl-3.0.en.html
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
# -------------------------------------------------------------------------------------------------

from nautilus_trader.cache.cache cimport Cache
from nautilus_trader.common.clock cimport Clock
from nautilus_trader.common.logging cimport Logger
from nautilus_trader.common.logging cimport LoggerAdapter
from nautilus_trader.core.message cimport Event
from nautilus_trader.core.uuid cimport UUID4
from nautilus_trader.execution.messages cimport CancelAllOrders
from nautilus_trader.execution.messages cimport CancelOrder
from nautilus_trader.execution.messages cimport ModifyOrder
from nautilus_trader.execution.messages cimport SubmitOrder
from nautilus_trader.execution.messages cimport SubmitOrderList
from nautilus_trader.execution.messages cimport TradingCommand
from nautilus_trader.model.events.order cimport OrderCanceled
from nautilus_trader.model.events.order cimport OrderEvent
from nautilus_trader.model.events.order cimport OrderExpired
from nautilus_trader.model.events.order cimport OrderFilled
from nautilus_trader.model.events.order cimport OrderRejected
from nautilus_trader.model.events.order cimport OrderUpdated
from nautilus_trader.model.events.position cimport PositionEvent
from nautilus_trader.model.identifiers cimport ClientId
from nautilus_trader.model.identifiers cimport InstrumentId
from nautilus_trader.model.identifiers cimport PositionId
from nautilus_trader.model.identifiers cimport StrategyId
from nautilus_trader.model.objects cimport Price
from nautilus_trader.model.objects cimport Quantity
from nautilus_trader.model.orders.base cimport Order
from nautilus_trader.msgbus.bus cimport MessageBus


cdef class OrderManager:
    cdef readonly Clock _clock
    cdef readonly LoggerAdapter _log
    cdef readonly MessageBus _msgbus
    cdef readonly Cache _cache

# -- COMMAND HANDLERS -----------------------------------------------------------------------------

    cpdef void cancel_order(self, Order order)

# -- EVENT HANDLERS -------------------------------------------------------------------------------

    cpdef void handle_position_event(self, PositionEvent event)
    cpdef void handle_order_rejected(self, OrderRejected rejected)
    cpdef void handle_order_canceled(self, OrderCanceled canceled)
    cpdef void handle_order_expired(self, OrderExpired expired)
    cpdef void handle_order_updated(self, OrderUpdated updated)
    cpdef void handle_order_filled(self, OrderFilled filled)
    cpdef void handle_contingencies(self, Order order)
    cpdef void handle_contingencies_update(self, Order order)
    cpdef void update_order_quantity(self, Order order, Quantity new_quantity)

# -- EGRESS ---------------------------------------------------------------------------------------

    cpdef void send_emulator_command(self, TradingCommand command)
    cpdef void send_algo_command(self, TradingCommand command)
    cpdef void send_risk_command(self, TradingCommand command)
    cpdef void send_exec_command(self, TradingCommand command)
    cpdef void send_risk_event(self, OrderEvent event)
    cpdef void send_exec_event(self, OrderEvent event)
